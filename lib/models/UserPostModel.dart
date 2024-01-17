import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserPostModel {
  String username;
  String description;
  String postdate;
  String profileImg;
  String postImg;
  String postID;
  String userID;
  List likes;

  UserPostModel({
    required this.username,
    required this.description,
    required this.postdate,
    required this.postImg,
    required this.profileImg,
    required this.postID,
    required this.userID,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'username': username,
      'postdate': postdate,
      'postImg': postImg,
      'profileImg': profileImg,
      'postID': postID,
      'userID': userID,
      'likes': likes,
    };
  }

  UserPostModel.fromfirebase(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : username = snapshot.data()!['username'],
        description = snapshot.data()!['description'],
        postdate = DateFormat('yMMMd')
            .format(DateTime.parse(snapshot.data()!['postdate'])),
        postImg = snapshot.data()!['postImg'],
        postID = snapshot.id,
        userID = snapshot.data()!['userID'],
        likes = snapshot.data()!["likes"],
        profileImg = snapshot.data()!['profileImg'];
}
