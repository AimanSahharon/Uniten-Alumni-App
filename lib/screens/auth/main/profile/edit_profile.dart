//TOREAD: This file is to allow user to edit their profile by uploading their profile images and banner similar to twitter
import 'dart:io';
import 'dart:typed_data'; // For web image handling
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For platform check
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/services/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserService _userService = UserService();
  XFile? _profileImage;
  XFile? _bannerImage;
  Uint8List? _webProfileImage;  // For web image handling
  Uint8List? _webBannerImage;   // For web image handling
  final picker = ImagePicker();
  String name = '';

  Future<void> getImage(int type) async {
    final pickedFile = await showDialog<XFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
            },
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
            },
            child: const Text('Choose from Gallery'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      if (type == 0) {
        _profileImage = pickedFile;
        if (kIsWeb) {
          _webProfileImage = await pickedFile.readAsBytes();
        }
      } else if (type == 1) {
        _bannerImage = pickedFile;
        if (kIsWeb) {
          _webBannerImage = await pickedFile.readAsBytes();
        }
      }
      // Call setState() synchronously after setting the images
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => getImage(0),
                child: Row(
                  children: [
                    _profileImage == null
                        ? const Icon(Icons.person, size: 100)
                        : kIsWeb
                            ? Image.memory(_webProfileImage!, height: 100, width: 100, fit: BoxFit.cover)  // Web: Use memory
                            : Image.file(File(_profileImage!.path), height: 100, width: 100, fit: BoxFit.cover),  // Mobile
                    const SizedBox(width: 10),
                    const Text("Edit Profile Picture"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => getImage(1),
                child: Row(
                  children: [
                    _bannerImage == null
                        ? const Icon(Icons.photo, size: 100)
                        : kIsWeb
                            ? Image.memory(_webBannerImage!, height: 100, width: 100, fit: BoxFit.cover)  // Web: Use memory
                            : Image.file(File(_bannerImage!.path), height: 100, width: 100, fit: BoxFit.cover),  // Mobile
                    const SizedBox(width: 10),
                    const Text("Edit Banner Image"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Convert XFile to File only on non-web platforms
                  File? profileImageFile = _profileImage != null && !kIsWeb ? File(_profileImage!.path) : null;
                  File? bannerImageFile = _bannerImage != null && !kIsWeb ? File(_bannerImage!.path) : null;

                  // Check if any field is updated
                  if (profileImageFile == null && bannerImageFile == null && name.isEmpty && _webProfileImage == null && _webBannerImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please update at least one field (name, profile image, or banner image)')),
                    );
                  } else {
                    // Call the updateProfile method with the provided data
                    await _userService.updateProfile(bannerImageFile, profileImageFile, name, _webProfileImage, _webBannerImage);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}