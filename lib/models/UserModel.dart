import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String title;
  final String username;
  final String email;
  final String password;
  final String uid;
  final String imageurl;
  final List? followers;
  final List? following;

  UserModel({
    required this.title,
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    required this.imageurl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'username': username,
      'email': email,
      'password': password,
      'imageurl': imageurl,
      'followers': followers,
      'following': following,
    };
  }

  UserModel.fromfirebase(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : email = snapshot.data()!['email'],
        imageurl = snapshot.data()!['imageurl'],
        password = snapshot.data()!['password'],
        title = snapshot.data()!['title'],
        uid = snapshot.id,
        username = snapshot.data()!['username'],
        followers = snapshot.data()!["followers"],
        following = snapshot.data()!['following'];
}
