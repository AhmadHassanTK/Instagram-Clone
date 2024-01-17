import 'package:flutter/foundation.dart';
import 'package:instagram/Cloud/UserCloudServices.dart';
import 'package:instagram/models/UserModel.dart';

class GuestProvider with ChangeNotifier {
  UserCloudServices userCloudServices = UserCloudServices();
  UserModel? guestModel;

  UserModel? get getGuestmodel => guestModel;

  GuestData({required userid}) async {
    final guestdata = await userCloudServices.getdata(userid: userid);
    guestModel = guestdata;
    notifyListeners();
  }
}
