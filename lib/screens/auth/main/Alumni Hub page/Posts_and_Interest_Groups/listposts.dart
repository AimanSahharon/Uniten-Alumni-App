/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';

class ListPosts extends StatefulWidget {
  const ListPosts({super.key});

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
      final posts = Provider.of<List<PostModel>>(context) ?? [];


    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.creator),
          subtitle: Text(post.text),
        );
      },
    );
  }
} */
//To display all the posts
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';

class ListPosts extends StatefulWidget {
  const ListPosts({super.key});

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context) ?? [];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adds space around each post
          padding: EdgeInsets.all(16.0), // Adds padding inside the white background
          decoration: BoxDecoration(
            color: Colors.white, // White background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Adds shadow to the container
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              post.creator,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.text),
          ),
        );
      },
    );
  }
}


