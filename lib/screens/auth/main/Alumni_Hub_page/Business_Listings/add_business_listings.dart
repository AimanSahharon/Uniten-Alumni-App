
//TOREAD: This is Add Post page where user can type their post and upload to Firebase database
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this import for image picker
import 'dart:io'; // For File
import 'package:uniten_alumni_app/services/businesslistings.dart';

class AddBusinessListings extends StatefulWidget {
  const AddBusinessListings({super.key});

  @override
  State<AddBusinessListings> createState() => _AddBusinessListingsState();
}

class _AddBusinessListingsState extends State<AddBusinessListings> {
  final BusinessListingsService _businessListingService = BusinessListingsService();
  String text = '';
  File? _image; // To hold the image file

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path); // Store the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _businessListingService.savePost(text, _image); // Pass the image along with the text
              Navigator.pop(context);
            },
            child: Text('Post'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    text = val;
                  });
                },
                decoration: InputDecoration(hintText: 'Enter your post'),
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!, height: 200) // Display selected image
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick an image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
