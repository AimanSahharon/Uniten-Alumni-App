/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(value: _postService.getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
    initialData: null,
    child: Scaffold(
      body: Container(
        child: ListPosts(),
      )
    ));
  }
} */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'edit_profile.dart'; // Import the EditProfile screen

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PostService _postService = PostService();
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _postService.getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
        body: Container(
          child: ListPosts(),
        ),
      ),
    );
  }
}

