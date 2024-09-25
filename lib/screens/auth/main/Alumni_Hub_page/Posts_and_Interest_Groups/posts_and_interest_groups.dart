
//This is to display Posts and Interest Groups page with different tabs such as Posts, Followed User Posts, Liked Posts and Interest Groups
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/feed.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/likedposts.dart'; // Import LikedPostsScreen
import 'package:uniten_alumni_app/services/posts.dart';

class PostsAndInterestGroups extends StatefulWidget {
  const PostsAndInterestGroups({super.key});

  @override
  State<PostsAndInterestGroups> createState() => _PostsAndInterestGroupsState();
}

class _PostsAndInterestGroupsState extends State<PostsAndInterestGroups> {
  final PostService _postsService = PostService();
  final TextEditingController _searchController = TextEditingController();
  Stream<List<PostModel>>? _postsStream;

  @override
  void initState() {
    super.initState();
    _postsStream = _postsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid);
  }

  void _searchPosts(String query) {
    if (query.isEmpty) {
      setState(() {
        _postsStream = _postsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid);
      });
    } else {
      setState(() {
        _postsStream = _postsService.searchPosts(query);
      });
    }
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _postsStream = _postsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsStream,
      initialData: const [],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Followed'),
                      Text('User Posts'),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Liked'),
                      Text('Posts'),
                    ],
                  ),
                ),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Posts Tab with Pull-to-Refresh
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 0, 0), // Red
                          Color.fromARGB(255, 128, 0, 255), // Purple
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search posts...',
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: _searchPosts,
                          ),
                        ),
                        Expanded(
                          child: ListPosts(
                            onRefresh: _refreshPosts, // Pull-to-refresh function
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255), // Purple
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AddPosts()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 10,
                            shadowColor: Colors.black.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Followed User Posts Tab
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 0, 0), // Red
                          Color.fromARGB(255, 128, 0, 255), // Purple
                        ],
                      ),
                    ),
                    child: const Expanded(
                      child: Feed(),
                    ),
                  ),
                ],
              ),

              // Liked Posts Tab
              Stack(
                children: [
                  const LikedPostsScreen(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

