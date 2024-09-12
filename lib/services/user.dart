import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/services/utils.dart'; // to use the image picker and use the File object

class UserService {
  final UtilsService _utilsService = UtilsService();

  List<UserModel> _userListFromQuerySnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        id: doc.id,
        bannerImageUrl: doc.data()['bannerImageUrl'] ?? '',
        profileImageUrl: doc.data()['profileImageUrl'] ?? '',
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
      );
    }).toList();
  }

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

  Future<List<String>> getUserFollowing(uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('following')
    .get();

    final users = querySnapshot.docs.map((doc) => doc.id).toList(); //display the list
    return users;
  }

  // To search users
  Stream<List<UserModel>> queryByName(String search) {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("name") 
        .startAt([search]) // If user search and type the first letter, start finding user starting those letters
        .endAt(['$search\uf8ff'])
        .limit(10) // Show 10 search results
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

   Stream<bool> isFollowing(uid, otherId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("following")
        .doc(otherId)
        .snapshots()
        .map((snapshot) {
          return snapshot.exists;
          });
  }

  Future<void> followUser(uid) async {
    await FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('following')
    .doc(uid)
    .set({});

    await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('followers')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .set({});
  }

  Future<void> unfollowUser(uid) async {
    await FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('following')
    .doc(uid)
    .delete();

    await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('followers')
    .doc(uid)
    .delete();
  }

/*
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
  } */

 Future<void> updateProfile(File? bannerImage, File? profileImage, String name, Uint8List? webProfileImage, Uint8List? webBannerImage) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    // Upload for web (Uint8List) or mobile (File)
    if (webBannerImage != null) {
      bannerImageUrl = await _utilsService.uploadFileFromBytes(
        webBannerImage, 
        'user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner'
      );
    } else if (bannerImage != null) {
      bannerImageUrl = await _utilsService.uploadFile(
        bannerImage, 
        'user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner'
      );
    }

    if (webProfileImage != null) {
      profileImageUrl = await _utilsService.uploadFileFromBytes(
        webProfileImage, 
        'user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile'
      );
    } else if (profileImage != null) {
      profileImageUrl = await _utilsService.uploadFile(
        profileImage, 
        'user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile'
      );
    }

    Map<String, dynamic> data = {};

    if (name.isNotEmpty) data['name'] = name;
    if (profileImageUrl.isNotEmpty) data['profileImageUrl'] = profileImageUrl;
    if (bannerImageUrl.isNotEmpty) data['bannerImageUrl'] = bannerImageUrl;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }
}