import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserCommentModel {
  String username;
  String caption;
  String imgpath;
  String commentdate;
  List likes;
  String userid;
  String commentid;

  UserCommentModel({
    required this.username,
    required this.caption,
    required this.commentdate,
    required this.imgpath,
    required this.likes,
    required this.userid,
    required this.commentid,
  });

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'username': username,
      'imgpath': imgpath,
      'commentdate': commentdate,
      'likes': likes,
      'userid': userid,
      'commentid': commentid,
    };
  }

  UserCommentModel.fromfirebase(QueryDocumentSnapshot<dynamic> snapshot)
      : username = snapshot.data()['username'],
        caption = snapshot.data()['caption'],
        commentdate = DateFormat('yMMMd')
            .format(DateTime.parse(snapshot.data()['commentdate'])),
        imgpath = snapshot.data()['imgpath'],
        commentid = snapshot.id,
        userid = snapshot.data()['userid'],
        likes = snapshot.data()["likes"];
}
