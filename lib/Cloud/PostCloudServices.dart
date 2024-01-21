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
    required String profileImg,
  }) async {
    try {
      final id = Uuid().v1();
      final url = await storage.getImgUrl(imgName: imgName, imgPath: imgPath);
      final post = UserPostModel(
        username: username,
        description: description,
        postdate: DateTime.now().toString(),
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

  Future<void> deletepost({
    required postid,
  }) async {
    await postsdatabase.doc(postid).delete();
  }

  Stream<Iterable<UserPostModel>> profileData({required String owneruserid}) =>
      postsdatabase.snapshots(includeMetadataChanges: true).map((event) => event
          .docs
          .map((doc) => UserPostModel.fromfirebase(doc))
          .where((postmodel) => postmodel.userID == owneruserid));

  Stream<Iterable<UserPostModel>> homedata({required BuildContext context}) {
    // final usermodel = Provider.of<UserProvider>(context).getUsermodel;

    return postsdatabase.snapshots(includeMetadataChanges: true).map(
        (event) => event.docs.map((doc) => UserPostModel.fromfirebase(doc)));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> numberofposts(
      {required userid}) async {
    final data = await postsdatabase.where('userID', isEqualTo: userid).get();

    return data;
  }

  Future<void> addlike({
    required BuildContext context,
    required String postid,
  }) async {
    try {
      await postsdatabase.doc(postid).update({
        'likes': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
    } catch (e) {
      showSnackBar(context, 'Failed to add the follower');
    }
  }

  Future<void> removelike({
    required BuildContext context,
    required String postid,
  }) async {
    try {
      await postsdatabase.doc(postid).update({
        'likes':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      });
    } catch (e) {
      showSnackBar(context, 'Failed to add the follower');
    }
  }
}
