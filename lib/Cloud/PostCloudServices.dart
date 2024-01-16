import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/Storage/storage.dart';
import 'package:instagram/models/UserPostModel.dart';
import 'package:uuid/uuid.dart';

class PostCloudServices {
  static final PostCloudServices _shared = PostCloudServices._shareInstance();
  PostCloudServices._shareInstance();
  factory PostCloudServices() => _shared;
  final postsdatabase = FirebaseFirestore.instance.collection('Posts');
  final Storage storage = Storage();

  Future<void> addPost({
    required String username,
    required String description,
    required BuildContext context,
    required Uint8List? imgPath,
    required String? imgName,
    //required List likes,
    required String profileImg,
  }) async {
    try {
      final id = Uuid().v1();
      final url = await storage.getImgUrl(imgName: imgName, imgPath: imgPath);
      final post = UserPostModel(
        username: username,
        description: description,
        postdate: DateTime.now(),
        postImg: url,
        profileImg: profileImg,
        postID: id,
        userID: FirebaseAuth.instance.currentUser!.uid,
        likes: [],
      ).toMap();

      await postsdatabase
          .doc(id)
          .set(post)
          .then((value) => print('Post added'));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);
    }

    showSnackBar(context, 'Done');
  }

  Future<UserPostModel> getdata({
    required userid,
  }) {
    return postsdatabase
        .doc(userid)
        .get()
        .then((value) => UserPostModel.fromfirebase(value));
  }
}
