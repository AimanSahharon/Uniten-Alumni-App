

/*import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class UtilsService {
  Future<String> uploadFile(File _image, String path) async {
    firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref(path);
    
  firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);

  await uploadTask.whenComplete(() => null);
  String returnURL = '';
  //get the url from firebase databse to get the images
  await storageReference.getDownloadURL().then((fileURL) {
    returnURL = fileURL;
  });
  return returnURL;
  }
} */

import 'dart:io';
import 'dart:typed_data'; // For web
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UtilsService {
  Future<String> uploadFile(File image, String path) async {
    firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref(path);
    firebase_storage.UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    String fileURL = await storageReference.getDownloadURL();
    return fileURL;
  }

  // For web uploads
  Future<String> uploadFileFromBytes(Uint8List imageData, String path) async {
    firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref(path);
    firebase_storage.UploadTask uploadTask = storageReference.putData(imageData);
    await uploadTask.whenComplete(() => null);
    String fileURL = await storageReference.getDownloadURL();
    return fileURL;
  }
}

