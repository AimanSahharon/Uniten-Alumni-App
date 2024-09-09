/*import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
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
              await _postService.editPost(widget.post.id, _textController.text);
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add image_picker package
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
  late TextEditingController _textController;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    // Load the current image if available
    if (widget.post.imageUrl != null) {
      _loadImage(widget.post.imageUrl!);
    }
  }

  Future<void> _loadImage(String imageUrl) async {
    // Optionally, you can use CachedNetworkImage or other methods to display the image.
    // Here, we'll use it for demonstration purposes.
    setState(() {
      // For example, you might set _imageFile with a local file reference or a placeholder
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _postService.editPost(
                widget.post.id,
                _textController.text,
                _imageFile,
              );
              Navigator.pop(context);
            },
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
            SizedBox(height: 16),
            if (widget.post.imageUrl != null)
              Image.network(widget.post.imageUrl!) // Display current image
            else if (_imageFile != null)
              Image.file(_imageFile!) // Display selected image
            else
              Placeholder(fallbackHeight: 200), // Placeholder if no image is available
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

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'dart:io';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
  late TextEditingController _textController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _savePost() async {
    await _postService.editPost(widget.post.id, _textController.text, _imageFile);
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
            SizedBox(height: 16.0),
            _imageFile != null
                ? Image.file(_imageFile!)
                : widget.post.imageUrl != null
                    ? Image.network(widget.post.imageUrl!)
                    : Container(),
            SizedBox(height: 16.0),
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



