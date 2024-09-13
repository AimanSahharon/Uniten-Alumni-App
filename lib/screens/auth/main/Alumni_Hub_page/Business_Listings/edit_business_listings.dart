/*import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class EditPostScreen extends StatefulWidget {
  final BusinessListingsModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _businessListingsService.editPost(widget.post.id, _textController.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Edit your post...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
} */

/*
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'dart:io';

class EditPostScreen extends StatefulWidget {
  final BusinessListingsModel post;

  const EditPostScreen({super.key, required this.post});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  late TextEditingController _textController;
  XFile? _imageFile; // Use XFile for web compatibility
  String? _existingImageUrl;

  // Define a constant for image height
  static const double _imageHeight = 200.0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _savePost() async {
    String? newImageUrl;

    if (_imageFile != null) {
      final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      try {
        Uint8List imageBytes = await _imageFile!.readAsBytes();
        final uploadTask = storageRef.putData(imageBytes);
        newImageUrl = await (await uploadTask).ref.getDownloadURL();
        print("Image uploaded successfully: $newImageUrl");
      } catch (e) {
        print("Error uploading image: $e");
        return;
      }
    } else {
      newImageUrl = _existingImageUrl;
    }

    try {
      await _businessListingsService.editPost(
        widget.post.id,
        _textController.text,
        _imageFile != null ? (kIsWeb ? null : File(_imageFile!.path)) : null,
        newImageUrl,
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error saving post: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          ElevatedButton(
            onPressed: _savePost,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Edit your post...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            _imageFile != null
                ? kIsWeb
                    ? FutureBuilder<Uint8List>(
                        future: _imageFile!.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              height: _imageHeight,
                              fit: BoxFit.cover,
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Error loading image');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      )
                    : Image.file(
                        File(_imageFile!.path),
                        height: _imageHeight,
                        fit: BoxFit.cover,
                      )
                : _existingImageUrl != null
                    ? Image.network(
                        _existingImageUrl!,
                        height: _imageHeight,
                        fit: BoxFit.cover,
                      )
                    : Container(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
} */


//TOREAD: This is to edit the business listings post. 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'dart:io';
import 'dart:typed_data';

class EditPostScreen extends StatefulWidget {
  final BusinessListingsModel post;

  const EditPostScreen({super.key, required this.post});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  late TextEditingController _textController;
  XFile? _imageFile; // Use XFile for web compatibility
  String? _existingImageUrl;

  // Define a constant for image height
  static const double _imageHeight = 200.0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _savePost() async {
    String? newImageUrl;

    if (_imageFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      try {
        Uint8List imageBytes = await _imageFile!.readAsBytes();
        final uploadTask = storageRef.putData(imageBytes);
        newImageUrl = await (await uploadTask).ref.getDownloadURL();
        print("Image uploaded successfully: $newImageUrl");
      } catch (e) {
        print("Error uploading image: $e");
        return;
      }
    } else {
      newImageUrl = _existingImageUrl;
    }

    try {
      await _businessListingsService.editPost(
        widget.post.id,
        _textController.text,
        _imageFile != null ? (kIsWeb ? null : File(_imageFile!.path)) : null,
        newImageUrl,
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error saving post: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          ElevatedButton(
            onPressed: _savePost,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Edit your post...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Image handling
            if (_imageFile != null)
              kIsWeb
                  ? FutureBuilder<Uint8List>(
                      future: _imageFile!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            height: _imageHeight,
                            fit: BoxFit.cover,
                          );
                        } else if (snapshot.hasError) {
                          return const Text('Error loading image');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
                  : Image.file(
                      File(_imageFile!.path),
                      height: _imageHeight,
                      fit: BoxFit.cover,
                    )
            else if (_existingImageUrl != null && _existingImageUrl!.isNotEmpty)
              Image.network(
                _existingImageUrl!,
                height: _imageHeight,
                fit: BoxFit.cover,
              )
            else
              const SizedBox.shrink(), // Use SizedBox.shrink() to avoid showing an empty container
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}


