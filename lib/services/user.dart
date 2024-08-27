import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/services/utils.dart'; // to use the image picker and use the File object

class UserService {
  final UtilsService _utilsService = UtilsService();

  UserModel? _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data != null) {
      return UserModel(
        id: snapshot.id,
        bannerImageUrl: data['bannerImageUrl'] ?? '',
        profileImageUrl: data['profileImageUrl'] ?? '',
        name: data['name'] ?? '',
        email: data['email'] ?? '',
      );
    } else {
      return null;
    }
  }

  Stream<UserModel?> getUserInfo(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Future<void> updateProfile(File? bannerImage, File? profileImage, String name) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if (bannerImage != null) {
      bannerImageUrl = await _utilsService.uploadFile(
          bannerImage, 'user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }

    if (profileImage != null) {
      profileImageUrl = await _utilsService.uploadFile(
          profileImage, 'user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile');
    }

    Map<String, dynamic> data = {}; // Use a plain Map

    if (name.isNotEmpty) data['name'] = name;
    if (profileImageUrl.isNotEmpty) data['profileImageUrl'] = profileImageUrl;
    if (bannerImageUrl.isNotEmpty) data['bannerImageUrl'] = bannerImageUrl;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }
}
