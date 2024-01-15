import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Authprovider {
  Future<UserCredential?> Register(
      {required String email,
      required String password,
      required BuildContext context});

  Future<UserCredential?> SignIn(
      {required String email,
      required String password,
      required BuildContext context});

  Future<void> SignOut();

  Stream<User?> getuserdata();

  Future<void> SendEmailVerfication();

  Future<void> SendForgetPasswordEmail({required String email});

  get user;
}
