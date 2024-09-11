/* Version 1
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
} */

/* USE THIS VERSION
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
    final pickedFile = await showDialog<XFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
            },
            child: Text('Take Photo'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
            },
            child: Text('Choose from Gallery'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        if (type == 0) {
          _profileImage = File(pickedFile.path);
        } else if (type == 1) {
          _bannerImage = File(pickedFile.path);
        }
      });
    }
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
              GestureDetector(
                onTap: () => getImage(0), 
                child: _profileImage == null 
                    ? Icon(Icons.person, size: 100) 
                    : Image.file(_profileImage!, height: 100, width: 100, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => getImage(1), 
                child: _bannerImage == null 
                    ? Icon(Icons.photo, size: 100) 
                    : Image.file(_bannerImage!, height: 100, width: 100, fit: BoxFit.cover),
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
                  if (_bannerImage != null && _profileImage != null) {
                    await _userService.updateProfile(_bannerImage!, _profileImage!, name);
                    Navigator.pop(context);
                  } else {
                    // Handle error: prompt user to select images
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select both profile and banner images')),
                    );
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

/*
//TOREAD: This file is to allow user to edit their profile by uploading their profile images and banner similar to twitter
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
    final pickedFile = await showDialog<XFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
            },
            child: Text('Take Photo'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
            },
            child: Text('Choose from Gallery'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        if (type == 0) {
          _profileImage = File(pickedFile.path);
        } else if (type == 1) {
          _bannerImage = File(pickedFile.path);
        }
      });
    }
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
              GestureDetector(
                onTap: () => getImage(0), 
                child: _profileImage == null 
                    ? Icon(Icons.person, size: 100) 
                    : Image.file(_profileImage!, height: 100, width: 100, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => getImage(1), 
                child: _bannerImage == null 
                    ? Icon(Icons.photo, size: 100) 
                    : Image.file(_bannerImage!, height: 100, width: 100, fit: BoxFit.cover),
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
              /*ElevatedButton(
                onPressed: () async {
                  if (_bannerImage != null && _profileImage != null) {
                    await _userService.updateProfile(_bannerImage!, _profileImage!, name);
                    Navigator.pop(context);
                  } else {
                    // Handle error: prompt user to select images
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select both profile and banner images')),
                    );
                  }
                },
                child: Text("Save"),
              ), */
              ElevatedButton(
                onPressed: () async {
                // Allow updating either profile image, banner image, or both.
                if (_profileImage == null && _bannerImage == null && name.isEmpty) {
                  // Handle error: prompt user to select at least one field to update
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please update at least one field (name, profile image, or banner image)')),
                  );
                } else {
                  // Update the profile with whichever fields are provided
                  await _userService.updateProfile(_bannerImage, _profileImage, name);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"))


            ],
          ),
        ),
      ),
    );
  }
} */


//TOREAD: This file is to allow user to edit their profile by uploading their profile images and banner similar to twitter
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
  final UserService _userService = UserService();
  
  File? _profileImage;
  File? _bannerImage;
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
      setState(() {
        if (type == 0) {
          _profileImage = File(pickedFile.path);
        } else if (type == 1) {
          _bannerImage = File(pickedFile.path);
        }
      });
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
                      : Image.file(_profileImage!, height: 100, width: 100, fit: BoxFit.cover),
                  const SizedBox(width: 10), // Add space between the icon and text
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
                      : Image.file(_bannerImage!, height: 100, width: 100, fit: BoxFit.cover),
                  const SizedBox(width: 10), // Add space between the icon and text
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
            const SizedBox(height: 20), // Add some space between the TextFormField and the button
            ElevatedButton(
              onPressed: () async {
                // Allow updating either profile image, banner image, or both.
                if (_profileImage == null && _bannerImage == null && name.isEmpty) {
                  // Handle error: prompt user to select at least one field to update
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please update at least one field (name, profile image, or banner image)')),
                  );
                } else {
                  // Update the profile with whichever fields are provided
                  await _userService.updateProfile(_bannerImage, _profileImage, name);
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
