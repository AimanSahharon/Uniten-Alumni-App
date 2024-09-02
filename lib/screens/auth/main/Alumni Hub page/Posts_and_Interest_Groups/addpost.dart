
//TOREAD: This is Add Post page where user can type their post and upload to Firebase database
import 'package:flutter/material.dart';
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
}
