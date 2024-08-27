//TOREAD: this is to save user pictures

import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniten_alumni_app/services/utils.dart'; //to use the image picker and use the File object

class UserService {
  UtilsService _utilsService = UtilsService();
  Future<void> updateProfile(File _bannerImage, File _profileImage, String name) async { //Future means the app doesn't know when this function will be called
  String bannerImageUrl = '';
  String profileImageUrl = '';

  if(_bannerImage != null) { //if image is not null or not empty then save the image to the Firebase storage
    bannerImageUrl = await _utilsService.uploadFile(_bannerImage, 'user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }
    if(_profileImage != null) { //if image is not null or not empty then save the image to the Firebase storage
    profileImageUrl = await _utilsService.uploadFile(_profileImage, 'user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile');
    }

    Map<String, Object> data = new HashMap();
    if (name != '') data['name'] = name; //if name is not empty then add to the HashMap
    if (profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;
    if (bannerImageUrl != '') data['bannerImageUrl'] = bannerImageUrl;

    await FirebaseFirestore.instance //to save the data to the firebase database
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .update(data);
  } 
}