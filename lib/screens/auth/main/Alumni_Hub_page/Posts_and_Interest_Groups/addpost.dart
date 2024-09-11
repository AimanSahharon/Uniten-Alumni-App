
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
} */


/*
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
} */

/*
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this import for image picker
import 'dart:io' if (dart.library.html) 'dart:html'; // Conditional import
import 'package:uniten_alumni_app/services/posts.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final PostService _postService = PostService();
  String text = '';
  XFile? _image; // Using XFile instead of File for web compatibility

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage; // Store the picked image as XFile
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
              await _postService.savePost(text, _image); // Pass the XFile image along with the text
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
                  ? Image.network(_image!.path, height: 200) // Use Image.network to display the image on web
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
} */

/*
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final PostService _postService = PostService();
  String text = '';
  XFile? _image; // Using XFile for compatibility with web

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage; // Store the picked image as XFile
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
              await _postService.savePost(text, _image); // Pass the XFile image along with the text
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
                  ? kIsWeb
                      ? FutureBuilder<Uint8List>(
                          future: _image!.readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              return Image.memory(
                                snapshot.data!,
                                height: 200,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error loading image');
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        )
                      : Image.file(
                          File(_image!.path),
                          height: 200,
                          fit: BoxFit.cover,
                        )
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
} */

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final PostService _postService = PostService();
  String text = '';
  XFile? _image; // Using XFile for compatibility with web

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage; // Store the picked image as XFile
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
              await _postService.savePost(text, _image); // Pass the XFile image along with the text
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
                  ? kIsWeb
                      ? FutureBuilder<Uint8List>(
                          future: _image!.readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              return Image.memory(
                                snapshot.data!,
                                height: 200,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error loading image');
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        )
                      : Image.file(
                          File(_image!.path),
                          height: 200,
                          fit: BoxFit.cover,
                        )
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

