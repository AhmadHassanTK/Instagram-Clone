import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Shared/Snackbar.dart';
import 'package:instagram/models/UserCommentModel.dart';
import 'package:uuid/uuid.dart';

class CommentCloudServices {
  final String postid;
  final CollectionReference commentsdatabase;
  CommentCloudServices({required this.postid})
      : commentsdatabase = FirebaseFirestore.instance
            .collection('Posts')
            .doc(postid)
            .collection('Comments');

  Future<void> addComment({
    required String username,
    required String caption,
    required BuildContext context,
    required String profileImg,
  }) async {
    try {
      final id = Uuid().v1();
      final post = UserCommentModel(
        username: username,
        caption: caption,
        commentdate: DateTime.now().toString(),
        imgpath: profileImg,
        commentid: id,
        userid: FirebaseAuth.instance.currentUser!.uid,
        likes: [],
      ).toMap();

      await commentsdatabase
          .doc(id)
          .set(post)
          .then((value) => print('Post added'));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);
    }

    showSnackBar(context, 'Done');
  }

  Stream<Iterable<UserCommentModel>> homedata() => commentsdatabase
      .orderBy('commentdate', descending: true)
      .snapshots(includeMetadataChanges: true)
      .map((event) =>
          event.docs.map((doc) => UserCommentModel.fromfirebase(doc)));

  Future<int> numberofComments() async {
    final data = await commentsdatabase.get();

    return data.docs.length;
  }
}
