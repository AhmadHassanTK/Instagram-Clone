import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  getImgUrl({required imgName, required imgPath}) async {
    final storageref = FirebaseStorage.instance.ref(imgName);
    UploadTask uploadTask = storageref.putData(imgPath!);
    TaskSnapshot snap = await uploadTask;

    String url = await snap.ref.getDownloadURL();

    return url;
  }
}
