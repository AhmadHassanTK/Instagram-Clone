import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/models/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserCloudServices userCloudServices = UserCloudServices();
  UserModel? userModel;

  UserModel? get getUsermodel => userModel;

  userData() async {
    final userdata = await userCloudServices.getdata(
        userid: FirebaseAuth.instance.currentUser!.uid);
    userModel = userdata;
    notifyListeners();
  }
}
