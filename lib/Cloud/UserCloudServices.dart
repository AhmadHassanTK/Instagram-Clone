import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/Storage/storage.dart';
import 'package:instagram/models/UserModel.dart';

class UserCloudServices {
  static final UserCloudServices _shared = UserCloudServices._shareInstance();
  UserCloudServices._shareInstance();
  factory UserCloudServices() => _shared;
  final userdatabase = FirebaseFirestore.instance.collection('Users');
  final Storage storage = Storage();

  Future<void> adduser({
    required String username,
    required String title,
    required String email,
    required String password,
    required BuildContext context,
    required Uint8List? imgPath,
    required String? imgName,
    required List followers,
    required List following,
  }) async {
    try {
      final url = await storage.getImgUrl(imgName: imgName, imgPath: imgPath);
      final user = UserModel(
        title: title,
        username: username,
        email: email,
        password: password,
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageurl: url,
        followers: followers,
        following: following,
      ).toMap();

      await userdatabase
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user)
          .then((value) => print('user added'));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);
    }

    showSnackBar(context, 'Done');
  }

  Future<UserModel> getdata({
    required userid,
  }) {
    return userdatabase
        .doc(userid)
        .get()
        .then((value) => UserModel.fromfirebase(value));
  }
}
