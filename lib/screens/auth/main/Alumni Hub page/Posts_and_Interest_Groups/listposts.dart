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
/*To display all the posts
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
} */

/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';

class ListPosts extends StatelessWidget {
  const ListPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context);

    // Handle the case when posts is null or empty
    if (posts == null || posts.isEmpty) {
      return Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adds space around each post
          padding: const EdgeInsets.all(16.0), // Adds padding inside the white background
          decoration: BoxDecoration(
            color: Colors.white, // White background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Adds shadow to the container
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              post.creator,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.text),
          ),
        );
      },
    );
  }
} */


/* BACK UP USE THIS ONE 2/9/2024
//TOREAD: this file is to display the posts to the user
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ListPosts extends StatelessWidget {
  const ListPosts({super.key});

  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    final posts = Provider.of<List<PostModel>>(context);

    // Handle the case when posts is null or empty
    if (posts == null || posts.isEmpty) {
      return Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return StreamBuilder<UserModel?>(
          stream: _userService.getUserInfo(post.creator), // Handle nullable UserModel
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator()); // show loading indicator while data is loading
            }

            final user = snapshot.data;
            return Container( // The User Interface elements to display the posts or the white card with the post on it
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0), // Adds space around each post
              padding: const EdgeInsets.all(0.0), // Adds padding inside the white background
              decoration: BoxDecoration(
                color: Colors.white, // White background color
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Adds shadow to the container
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile( // Create a list of posts
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(
                    children: [
                      user?.profileImageUrl.isNotEmpty == true
                          ? CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user!.profileImageUrl),
                            )
                          : Icon(Icons.person, size: 40), // Corrected to use Icons.person
                      SizedBox(width: 10),
                      Text(user?.name ?? 'Unknown User', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.text),
                          SizedBox(height: 20),
                          Text(post.timestamp.toDate().toString())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
} */

/*BACK UP USE THIS ONE
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ListPosts extends StatelessWidget {
  const ListPosts({super.key});

  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    PostService _postService = PostService();
    final posts = Provider.of<List<PostModel>>(context);

    // Handle the case when posts is null or empty
    if (posts == null || posts.isEmpty) {
      return const Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        
        return StreamBuilder<UserModel?>(
          stream: _userService.getUserInfo(post.creator),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
            if (!snapshotUser.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = snapshotUser.data;
            return StreamBuilder<bool>(
              stream: _postService.getCurrentUserLike(post),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                if (!snapshotLike.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Row(
                        children: [
                          user?.profileImageUrl.isNotEmpty == true
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(user!.profileImageUrl),
                                )
                              : const Icon(Icons.person, size: 40),
                          const SizedBox(width: 10),
                          Text(user?.name ?? 'Unknown User', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.text),
                              const SizedBox(height: 20),
                              Text(post.timestamp.toDate().toString()),
                              const SizedBox(height: 20),
                              IconButton(
                                icon: Icon(
                                  snapshotLike.data! ? Icons.favorite : Icons.favorite_border, 
                                  color: Colors.red, 
                                  size: 30.0
                                ),
                                onPressed: () {
                                  _postService.likePost(post, snapshotLike.data!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
} */

//TOREAD: This is file is to list the posts itself with the white card

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ListPosts extends StatelessWidget {
  const ListPosts({super.key});

  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    PostService _postService = PostService();
    final posts = Provider.of<List<PostModel>>(context);

    if (posts == null || posts.isEmpty) {
      return const Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').doc(post.id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshotPost) {
            if (!snapshotPost.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final post = PostModel.fromFirestore(snapshotPost.data!);
            return StreamBuilder<UserModel?>(
              stream: _userService.getUserInfo(post.creator),
              builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
                if (!snapshotUser.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshotUser.data;
                return StreamBuilder<bool>(
                  stream: _postService.getCurrentUserLike(post),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                    if (!snapshotLike.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Row(
                            children: [
                              user?.profileImageUrl.isNotEmpty == true
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(user!.profileImageUrl),
                                    )
                                  : const Icon(Icons.person, size: 40),
                              const SizedBox(width: 10),
                              Text(user?.name ?? 'Unknown User', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post.text),
                                  const SizedBox(height: 20),
                                  Text(post.timestamp.toDate().toString()),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      IconButton(
                                        iconSize: 30.0,
                                        icon: snapshotLike.data!
                                            ? ShaderMask(
                                                shaderCallback: (bounds) => const LinearGradient(
                                                  colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds),
                                                child: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                        onPressed: () {
                                          _postService.likePost(post, snapshotLike.data!);
                                        },
                                      ),
                                      Text('${post.likeCount}', style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
