// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Auth/Authprovider.dart';
import 'package:instagram/Shared/Snackbar.dart';

class FirebaseAuthprovider implements Authprovider {
  // final CloudServices cloudServices = CloudServices();
  @override
  Stream<User?> getuserdata() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  get user {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<UserCredential?> Register({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
        print('The account already exists for that email.');
      }
    }
  }

  @override
  Future<UserCredential?> SignIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);
      print(e.code);
    }
  }

  @override
  Future<void> SignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> SendEmailVerfication() async {
    try {
      final userisverfied = FirebaseAuth.instance.currentUser!.emailVerified;
      final user = FirebaseAuth.instance.currentUser;

      if (!userisverfied) {
        await user!.sendEmailVerification();
      }
    } catch (e) {
      throw FirebaseAuthException;
    }
  }

  @override
  Future<void> SendForgetPasswordEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw FirebaseAuthException;
    }
  }
}
