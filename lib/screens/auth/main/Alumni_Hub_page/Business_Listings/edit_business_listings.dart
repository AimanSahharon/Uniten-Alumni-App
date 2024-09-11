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
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _savePost() async {
    await _businessListingsService.editPost(widget.post.id, _textController.text, _imageFile);
    Navigator.pop(context);
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
      body: Padding(
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
                ? Image.file(_imageFile!)
                : widget.post.imageUrl != null
                    ? Image.network(widget.post.imageUrl!)
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'dart:io';
import 'dart:typed_data'; // Import for Uint8List
import 'dart:html' as html; // Import for web file picker

class EditPostScreen extends StatefulWidget {
  final BusinessListingsModel post;

  const EditPostScreen({super.key, required this.post});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  late TextEditingController _textController;
  File? _imageFile; // For mobile
  Uint8List? _webImage; // For web

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
  }

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
          _imageFile = File(pickedImage.path); // Store the picked image
        });
      }
    }
  }

  Future<void> _savePost() async {
    await _businessListingsService.editPost(widget.post.id, _textController.text, _imageFile, _webImage);
    Navigator.pop(context);
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the column items
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
              // Center the image and button
              Center(
                child: _imageFile != null
                    ? ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200), // Limit the height of the image
                        child: Image.file(_imageFile!),
                      )
                    : _webImage != null
                        ? ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 200), // Limit the height of the image
                            child: Image.memory(_webImage!),
                          )
                        : widget.post.imageUrl != null
                            ? ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 200), // Limit the height of the image
                                child: Image.network(widget.post.imageUrl!),
                              )
                            : Container(),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


