/*import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart'; // Ensure this import path is correct

class PostsAndInterestGroups extends StatelessWidget {
  const PostsAndInterestGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController( //creating a Tab
        length: 2,
        child: Scaffold( //Creating App Bar
          appBar: AppBar(
            leading: IconButton( //Creating back button, when pressed it goes back to Alumni hub
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back to the previous screen
              },
            ),
            bottom: TabBar( //creating the tab itself
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: Text('Posts and Interest Groups'), //title that will display on the app bar
          ),
          body: TabBarView(
            children: [
              //Post Tab Content
              Stack(
                children: [
                  // Background Container
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
                    child: Center(
                      child: Text(
                        'Posts Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Positioned Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Round corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'Add Post',
                          style: TextStyle(color: Colors.black), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Interest Groups Tab Content
              Stack(
                children: [
                  // Background Container
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
                    child: Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Positioned Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Round corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'Add Interest Group Post',
                          style: TextStyle(color: Colors.black), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/* USE THIS ONE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class PostsAndInterestGroups extends StatefulWidget {
  const PostsAndInterestGroups({super.key});

  @override
  State<PostsAndInterestGroups> createState() => _PostsAndInterestGroupsState();
}

class _PostsAndInterestGroupsState extends State<PostsAndInterestGroups> {
  final PostService _postsService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsService.getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
      initialData: [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                    child: const Center(
                      child: ListPosts(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Interest Group Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */
/* USE THIS ONE LATEST
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class PostsAndInterestGroups extends StatefulWidget {
  const PostsAndInterestGroups({super.key});

  @override
  State<PostsAndInterestGroups> createState() => _PostsAndInterestGroupsState();
}

class _PostsAndInterestGroupsState extends State<PostsAndInterestGroups> {
  final PostService _postsService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid), //use getAllPost method to retrieve all post
      initialData: [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                    child: const Center(
                      child: ListPosts(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Interest Group Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */
/* USE THIS ONE LATEST FRFR
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class PostsAndInterestGroups extends StatefulWidget {
  const PostsAndInterestGroups({super.key});

  @override
  State<PostsAndInterestGroups> createState() => _PostsAndInterestGroupsState();
}

class _PostsAndInterestGroupsState extends State<PostsAndInterestGroups> {
  final PostService _postsService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid), //use getAllPost method to retrieve all post
      initialData: [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                    child: const Center(
                      child: ListPosts(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Interest Group Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

/*WITH COLOR GRADIENT BUTTONS
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsStream,
      initialData: [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search posts...',
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white, // Set the fill color to white
                              filled: true, // Enable the fill color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: _searchPosts,
                          ),
                        ),
                        const Expanded(
                          child: ListPosts(),
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
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            shadowColor: Colors.transparent, // Optional: Remove shadow color if needed
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

              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            shadowColor: Colors.transparent, // Optional: Remove shadow color if needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Interest Group Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */




/*WHITE BUTTON
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';

class PostsAndInterestGroups extends StatefulWidget {
  const PostsAndInterestGroups({super.key});

  @override
  State<PostsAndInterestGroups> createState() => _PostsAndInterestGroupsState();
}

class _PostsAndInterestGroupsState extends State<PostsAndInterestGroups> {
  final PostService _postsService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid),
      initialData: [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                    child: const Center(
                      child: ListPosts(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10, // Set the shadow elevation
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5, // Set the shadow elevation
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Add Interest Group Post',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

/* ONLY HAS POST AND INTEREST GROuP TAB
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsStream,
      initialData: [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Followed User Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search posts...',
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white, // Set the fill color to white
                              filled: true, // Enable the fill color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: _searchPosts,
                          ),
                        ),
                        const Expanded(
                          child: ListPosts(),
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
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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

              // Follow User Post Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 5, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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


              //
              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 5, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Interest Group Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */

/*
//TOREAD: This is file is to display Posts and Interest Groups page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/screens/auth/main/feed.dart';
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

  

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsStream,
      initialData: [],
      child: DefaultTabController(
        length: 3, // Adjusted to match the number of tabs
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
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search posts...',
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white, // Set the fill color to white
                              filled: true, // Enable the fill color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: _searchPosts,
                          ),
                        ),
                        const Expanded(
                          child: ListPosts(),
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
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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

              // User Posts under Followed Tab Content
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
                        const Expanded(
                          child: Feed(),
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
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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
              


              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 5, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Interest Group Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} */



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

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>?>.value(
      value: _postsStream,
      initialData: [],
      child: DefaultTabController(
        length: 4, // Adjusted to match the number of tabs
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
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Interest'),
                      Text('Groups'),
                    ],
                  ),
                ),
              ],
            ),
            title: const Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
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
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search posts...',
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white, // Set the fill color to white
                              filled: true, // Enable the fill color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: _searchPosts,
                          ),
                        ),
                        const Expanded(
                          child: ListPosts(),
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
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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

              // User Posts under Followed Tab Content
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
                        const Expanded(
                          child: Feed(),
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
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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

              // Liked Posts Tab Content
              Stack(
                children: [
                  LikedPostsScreen(), // Navigate to LikedPostsScreen
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
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


              // Interest Groups Tab Content
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
                    child: const Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 5, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Interest Group Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
