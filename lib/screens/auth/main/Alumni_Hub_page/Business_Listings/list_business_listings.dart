/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/comment_business_listing.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/edit_business_listings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:uniten_alumni_app/services/user.dart';

class BusinessListings extends StatelessWidget {
  const BusinessListings({super.key});

  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    BusinessListingsService _businessListingsService = BusinessListingsService();
    final posts = Provider.of<List<BusinessListingsModel>>(context);

    if (posts == null || posts.isEmpty) {
      return const Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length + 1, // Add an extra item for the padding
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return SizedBox(height: 80.0); // Add extra space after the last post
        }

        final post = posts[index];

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('Business Listing posts').doc(post.id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshotPost) {
            if (!snapshotPost.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final post = BusinessListingsModel.fromFirestore(snapshotPost.data!);
            return StreamBuilder<UserModel?>(
              stream: _userService.getUserInfo(post.creator),
              builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
                if (!snapshotUser.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshotUser.data;
                return StreamBuilder<bool>(
                  stream: _businessListingsService.getCurrentUserLike(post),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                    if (!snapshotLike.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    bool isCreator = post.creator == FirebaseAuth.instance.currentUser?.uid;

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
                                          _businessListingsService.likePost(post, snapshotLike.data!);
                                        },
                                      ),
                                      Text('${post.likeCount}', style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.comment),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CommentScreen(post: post),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('${post.commentCount ?? 0}', style: const TextStyle(fontSize: 16)),
                                      if (isCreator) ...[
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPostScreen(post: post),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            await _businessListingsService.deletePost(post.id);
                                          },
                                        ),
                                      ],
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
} */

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/comment_business_listing.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/edit_business_listings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:uniten_alumni_app/services/user.dart';

class BusinessListings extends StatelessWidget {
  const BusinessListings({super.key});

  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    BusinessListingsService _businessListingsService = BusinessListingsService();
    final posts = Provider.of<List<BusinessListingsModel>>(context);

    if (posts == null || posts.isEmpty) {
      return const Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length + 1, // Add an extra item for the padding
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return SizedBox(height: 80.0); // Add extra space after the last post
        }

        final post = posts[index];

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('Business Listing posts').doc(post.id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshotPost) {
            if (!snapshotPost.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final post = BusinessListingsModel.fromFirestore(snapshotPost.data!);
            return StreamBuilder<UserModel?>(
              stream: _userService.getUserInfo(post.creator),
              builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
                if (!snapshotUser.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshotUser.data;
                return StreamBuilder<bool>(
                  stream: _businessListingsService.getCurrentUserLike(post),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                    if (!snapshotLike.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    bool isCreator = post.creator == FirebaseAuth.instance.currentUser?.uid;

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
                                  const SizedBox(height: 10),

                                  // Display the image if it exists
                                  if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Container(
                                      height: 200, // Set the desired height
                                      width: double.infinity, // Ensure the image fills the width of the container
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(post.imageUrl!),
                                          fit: BoxFit.contain, // Scale the image to fit inside the container without cropping
                                        ),
                                      ),
                                    ),
                                  ),



                                  const SizedBox(height: 10),
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
                                          _businessListingsService.likePost(post, snapshotLike.data!);
                                        },
                                      ),
                                      Text('${post.likeCount}', style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.comment),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CommentScreen(post: post),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('${post.commentCount ?? 0}', style: const TextStyle(fontSize: 16)),
                                      if (isCreator) ...[
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPostScreen(post: post),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            await _businessListingsService.deletePost(post.id);
                                          },
                                        ),
                                      ],
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
} */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/comment_business_listing.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/edit_business_listings.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/profile.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:uniten_alumni_app/services/user.dart';

class BusinessListings extends StatelessWidget {
  const BusinessListings({super.key});

  @override
  Widget build(BuildContext context) {
    UserService _userService = UserService();
    BusinessListingsService _businessListingsService = BusinessListingsService();
    final posts = Provider.of<List<BusinessListingsModel>>(context);

    if (posts == null || posts.isEmpty) {
      return const Center(
        child: Text('No posts available.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: posts.length + 1, // Add an extra item for the padding
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return SizedBox(height: 80.0); // Add extra space after the last post
        }

        final post = posts[index];

        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('Business Listing posts').doc(post.id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshotPost) {
            if (!snapshotPost.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final post = BusinessListingsModel.fromFirestore(snapshotPost.data!);
            return StreamBuilder<UserModel?>(
              stream: _userService.getUserInfo(post.creator),
              builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshotUser) {
                if (!snapshotUser.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshotUser.data;
                return StreamBuilder<bool>(
                  stream: _businessListingsService.getCurrentUserLike(post),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshotLike) {
                    if (!snapshotLike.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    bool isCreator = post.creator == FirebaseAuth.instance.currentUser?.uid;

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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(uid: post.creator), // Navigate to the user's profile
                                    ),
                                  );
                                },
                                child: Text(user?.name ?? 'Unknown User', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
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
                                  const SizedBox(height: 10),

                                  // Display the image if it exists
                                  if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Container(
                                      height: 200, // Set the desired height
                                      width: double.infinity, // Ensure the image fills the width of the container
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(post.imageUrl!),
                                          fit: BoxFit.contain, // Scale the image to fit inside the container without cropping
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),
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
                                          _businessListingsService.likePost(post, snapshotLike.data!);
                                        },
                                      ),
                                      Text('${post.likeCount}', style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.comment),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CommentScreen(post: post),
                                            ),
                                          );
                                        },
                                      ),
                                      Text('${post.commentCount ?? 0}', style: const TextStyle(fontSize: 16)),
                                      if (isCreator) ...[
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPostScreen(post: post),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            await _businessListingsService.deletePost(post.id);
                                          },
                                        ),
                                      ],
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








