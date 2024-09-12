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

/*
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
} */

/*
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
} */

/*
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
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
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
    await _postService.editPost(
      widget.post.id,
      _textController.text,
      _imageFile,
      _existingImageUrl,
    );
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
                : _existingImageUrl != null
                    ? Image.network(_existingImageUrl!)
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
}*/
/*
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
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
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
    await _postService.editPost(
      widget.post.id,
      _textController.text,
      _imageFile,
      _existingImageUrl,
    );
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
                : _existingImageUrl != null
                    ? Image.network(_existingImageUrl!)
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
} */

/*
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'dart:io';
import 'dart:typed_data';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
  late TextEditingController _textController;
  XFile? _imageFile; // Use XFile for web compatibility
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _savePost() async {
    await _postService.editPost(
      widget.post.id,
      _textController.text,
      _imageFile != null ? (kIsWeb ? null : File(_imageFile!.path)) : null,
      _existingImageUrl,
    );
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
                ? kIsWeb
                    ? FutureBuilder<Uint8List>(
                        future: _imageFile!.readAsBytes(),
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
                        File(_imageFile!.path),
                        height: 200,
                        fit: BoxFit.cover,
                      )
                : _existingImageUrl != null
                    ? Image.network(_existingImageUrl!)
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
} */

/*
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'dart:io';
import 'dart:typed_data';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
  late TextEditingController _textController;
  XFile? _imageFile; // Use XFile for web compatibility
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _savePost() async {
    await _postService.editPost(
      widget.post.id,
      _textController.text,
      _imageFile != null ? (kIsWeb ? null : File(_imageFile!.path)) : null,
      _existingImageUrl,
    );
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
                ? kIsWeb
                    ? FutureBuilder<Uint8List>(
                        future: _imageFile!.readAsBytes(),
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
                        File(_imageFile!.path),
                        height: 200,
                        fit: BoxFit.cover,
                      )
                : _existingImageUrl != null
                    ? Image.network(_existingImageUrl!)
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
} */


/* THIS ONE IS PERFECT JUST SIZE PROBLEM
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'dart:io';
import 'dart:typed_data';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
  late TextEditingController _textController;
  XFile? _imageFile; // Use XFile for web compatibility
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.post.text);
    _existingImageUrl = widget.post.imageUrl; // Preserve existing image URL
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

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
      await _postService.editPost(
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
            SizedBox(height: 16.0),
            _imageFile != null
                ? kIsWeb
                    ? FutureBuilder<Uint8List>(
                        future: _imageFile!.readAsBytes(),
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
                        File(_imageFile!.path),
                        height: 200,
                        fit: BoxFit.cover,
                      )
                : _existingImageUrl != null
                    ? Image.network(_existingImageUrl!)
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
} */

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'dart:io';
import 'dart:typed_data';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({super.key, required this.post});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostService _postService = PostService();
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
      await _postService.editPost(
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
}
