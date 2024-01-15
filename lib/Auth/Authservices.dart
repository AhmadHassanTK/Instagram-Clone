import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Auth/Authprovider.dart';

class Authservices {
  Authprovider provider;
  Authservices(this.provider);
  Future<UserCredential?> Register(
          {required String email,
          required String password,
          required BuildContext context}) =>
      provider.Register(email: email, password: password, context: context);

  Future<UserCredential?> SignIn(
          {required String email,
          required String password,
          required BuildContext context}) =>
      provider.SignIn(email: email, password: password, context: context);

  Future<void> SignOut() => provider.SignOut();

  Stream<User?> getuserdata() => provider.getuserdata();

  Future<void> SendEmailVerfication() => provider.SendEmailVerfication();

  Future<void> SendForgetPasswordEmail({required String email}) =>
      provider.SendForgetPasswordEmail(email: email);

  get user => provider.user;
}
