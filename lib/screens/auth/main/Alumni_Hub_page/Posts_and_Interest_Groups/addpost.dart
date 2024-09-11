
//TOREAD: This is Add Post page where user can type their post and upload to Firebase database
/*import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final PostService _postService = PostService();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'), //title page
        actions: [
          ElevatedButton( //Post button, when user tap on post button, use the _postService function in post.dart in Service folder, to upload the post to firebase database
            onPressed: () async { 
              await _postService.savePost(text);
              Navigator.pop(context); // Once user posts, go back to the previous page
            },
            child: Text('Post'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: TextFormField( //To accept user input by typing the content for their posts
            onChanged: (val) {
              setState(() {
                text = val;
              });
            },
          ),
        ),
      ),
    );
  }
} */


/*
//TOREAD: This is Add Post page where user can type their post and upload to Firebase database
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this import for image picker
import 'dart:io'; // For File
import 'package:uniten_alumni_app/services/posts.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final PostService _postService = PostService();
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
        title: const Text('Add Post'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _postService.savePost(text, _image); // Pass the image along with the text
              Navigator.pop(context);
            },
            child: const Text('Post'),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    text = val;
                  });
                },
                decoration: const InputDecoration(hintText: 'Enter your post'),
              ),
              const SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!, height: 200) // Display selected image
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick an image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} */


//WITH WEB SUPPORT
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this import for image picker
import 'dart:io'; // For File
import 'package:uniten_alumni_app/services/posts.dart';

import 'dart:html' as html; // Import for web file picker
// Import for Uint8List

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final PostService _postService = PostService();
  String text = '';
  File? _image; // For mobile
  Uint8List? _webImage; // For web

  // Function to pick an image
  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Web
      final fileInput = html.FileUploadInputElement();
      fileInput.accept = 'image/*';
      fileInput.onChange.listen((e) async {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(fileInput.files![0]);

        reader.onLoadEnd.listen((e) {
          setState(() {
            _webImage = reader.result as Uint8List;
          });
        });
      });

      fileInput.click();
    } else {
      // Mobile
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path); // Store the picked image
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _postService.savePost(text, _image, _webImage); // Pass the image along with the text
              Navigator.pop(context);
            },
            child: const Text('Post'),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    text = val;
                  });
                },
                decoration: const InputDecoration(hintText: 'Enter your post'),
              ),
              const SizedBox(height: 20),
              if (_image != null)
                Image.file(_image!, height: 200) // Display selected image for mobile
              else if (_webImage != null)
                Image.memory(_webImage!, height: 200) // Display selected image for web
              else
                const SizedBox.shrink(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick an image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
