//TOREAD: This is to only display the post that the current logged in user is following and not all the user's posts
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final PostService _postService = PostService();

  Future<void> _refreshFeed() async {
    // Trigger a reload of the user's feed from the PostService
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<PostModel>>.value(
      value: _postService.getFeed(FirebaseAuth.instance.currentUser!.uid),
      initialData: const <PostModel>[],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 0, 0),
                Color.fromARGB(255, 128, 0, 255)
              ], // Customize gradient colors for background colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListPosts(onRefresh: _refreshFeed), // Pass the refresh function here
        ),
      ),
    );
  }
}

