import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/services/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserService _userService = UserService();
  
  File? _profileImage;
  File? _bannerImage;
  final picker = ImagePicker();
  String name = '';

  Future<void> getImage(int type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        if (type == 0) {
          _profileImage = File(pickedFile.path);
        } else if (type == 1) {
          _bannerImage = File(pickedFile.path);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => getImage(0), 
                child: _profileImage == null 
                    ? Icon(Icons.person) 
                    : Image.file(_profileImage!, height: 100),
              ),
              ElevatedButton(
                onPressed: () => getImage(1), 
                child: _bannerImage == null 
                    ? Icon(Icons.person) 
                    : Image.file(_bannerImage!, height: 100),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
              SizedBox(height: 20), // Add some space between the TextFormField and the button
              ElevatedButton(
                onPressed: () async {
                  await _userService.updateProfile(_bannerImage!, _profileImage!, name);
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
