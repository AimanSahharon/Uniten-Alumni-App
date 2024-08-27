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
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart'; // Import the EditProfile screen

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostService _postService = PostService();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(FirebaseAuth.instance.currentUser!.uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        return Image.network(
                          userModel?.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Consumer<UserModel?>(
                          builder: (context, userModel, child) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(
                                      userModel?.profileImageUrl ?? '',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.person, size: 60),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const EditProfile()),
                                        );
                                      },
                                      child: const Text("Edit Profile"),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      userModel?.name ?? 'User Name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: const ListPosts(),
          ),
        ),
      ),
    );
  }
}
