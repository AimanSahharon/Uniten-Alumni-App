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
/*
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
} */

/*
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
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(widget.uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(widget.uid),
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
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
                                          MaterialPageRoute(
                                              builder: (context) => const EditProfile()),
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
} */


/*
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
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid; // Use the uid passed through the constructor

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
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
} */
/*Use this one
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
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid; // Use the uid passed through the constructor

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
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
                                    CircleAvatar(
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
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
} */

/*WITH TABS USE THIS ONE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer<UserModel?>(
                          builder: (context, userModel, child) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if(FirebaseAuth.instance.currentUser?.uid == uid) //if the user is currently logged in 
                                    ElevatedButton( //create edit profile button
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile()),
                                        );
                                      },
                                      child: const Text("Edit Profile"),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 10),
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
                      // Add the TabBar below the profile section
                      const TabBar(
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Text('Info Content')), // Placeholder for Info tab content
                ListPosts(), // Posts tab content
                Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
              ],
            ),
          ),
        ),
      ),
    );
  }
} */
/* BACKUP USE THIS ONE LATEST
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid)
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false)
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true)
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
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
                      const TabBar(
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Text('Info Content')), // Placeholder for Info tab content
                ListPosts(), // Posts tab content
                Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
              ],
            ),
          ),
        ),
      ),
    );
  }
} */
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid)
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false)
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true)
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
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
                      const TabBar(
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Text('Info Content')), // Placeholder for Info tab content
                Stack(
                  children: [
                    ListPosts(), // Posts tab content
                    Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser?.uid == uid) { //if the user is currently logged in and in their profile page show this button else in another user profile then don't show it
                          return Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
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
                          );
                        }
                        return SizedBox.shrink(); // Return an empty widget if the condition is not met
                      },
                    ),
                  ],
                ),
                Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
              ],
            ),
          ),
        ),
      ),
    );
  }
} */

/*
//TOREAD: This is file is to display Profile page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar( //For Banner Image
                  floating: false,
                  pinned: true,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        return Image.network(
                          userModel?.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar( //To make the background image circular
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid) //If the current user is logged in and they are viewing their own profile show Edit Profile button. If current user is viewing other user than show Follow/Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false) //if current user has not follow other user then show Follow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true) //if current user has follow the other user then show Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft, //To display user name
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
                      const TabBar( //Creating tabs for Info,Posts, Interest Groups and Business Listings
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Text('Info Content')), // Placeholder for Info tab content
                Stack(
                  children: [
                    ListPosts(), // Posts tab content
                    Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser?.uid == uid) { //if the user is currently logged in and in their profile page show the Add Post button else in another user profile then don't show it
                          return Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255),],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const AddPosts()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent, // Set to transparent to show gradient
                                    shadowColor: Colors.transparent, // Remove default shadow
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
                          );
                        }
                        return SizedBox.shrink(); // Return an empty widget if the condition is not met
                      },
                    ),
                  ],
                ),
                Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
              ],
            ),
          ),
        ),
      ),
    );
  }
} */
/*
//TOREAD: This is file is to display Profile page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar( //For Banner Image
                  floating: false,
                  pinned: true,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        return Image.network(
                          userModel?.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar( //To make the background image circular
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid) //If the current user is logged in and they are viewing their own profile show Edit Profile button. If current user is viewing other user than show Follow/Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false) //if current user has not follow other user then show Follow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true) //if current user has follow the other user then show Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft, //To display user name
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
                      const TabBar( //Creating tabs for Info,Posts, Interest Groups and Business Listings
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Text('Info Content')), // Placeholder for Info tab content
                Stack(
                  children: [
                    ListPosts(), // Posts tab content
                    Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser?.uid == uid) { //if the user is currently logged in and in their profile page show the Add Post button else in another user profile then don't show it
                          return Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255),],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const AddPosts()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent, // Set to transparent to show gradient
                                    shadowColor: Colors.transparent, // Remove default shadow
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
                          );
                        }
                        return SizedBox.shrink(); // Return an empty widget if the condition is not met
                      },
                    ),
                  ],
                ),
                Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
              ],
            ),
          ),
        ),
      ),
    );
  }
} */

//TOREAD: This is file is to display Profile page
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar( //For Banner Image
                  floating: false,
                  pinned: true,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        return Image.network(
                          userModel?.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar( //To make the background image circular
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid) //If the current user is logged in and they are viewing their own profile show Edit Profile button. If current user is viewing other user than show Follow/Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false) //if current user has not follow other user then show Follow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true) //if current user has follow the other user then show Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft, //To display user name
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
                      const TabBar( //Creating tabs for Info,Posts, Interest Groups and Business Listings
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Text('Info Content')), // Placeholder for Info tab content
                Stack(
                  children: [
                    ListPosts(), // Posts tab content
                    Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser?.uid == uid) { //if the user is currently logged in and in their profile page show the Add Post button else in another user profile then don't show it
                          return Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255),],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const AddPosts()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent, // Set to transparent to show gradient
                                    shadowColor: Colors.transparent, // Remove default shadow
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
                          );
                        }
                        return SizedBox.shrink(); // Return an empty widget if the condition is not met
                      },
                    ),
                  ],
                ),
                Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
              ],
            ),
          ),
        ),
      ),
    );
  }
} */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/list_business_listings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: const [],
          
        ),
        StreamProvider<List<BusinessListingsModel>?>.value(
          value: _businessListingsService.getPostsByUser(uid),
          initialData: const [],
          
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar( //For Banner Image
                  floating: false,
                  pinned: true,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        return Image.network(
                          userModel?.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return const Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar( //To make the background image circular
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(
                                          userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? const Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid) //If the current user is logged in and they are viewing their own profile show Edit Profile button. If current user is viewing other user than show Follow/Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false) //if current user has not follow other user then show Follow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true) //if current user has follow the other user then show Unfollow button
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft, //To display user name
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
                      const TabBar( //Creating tabs for Info,Posts, Interest Groups and Business Listings
                        tabs: [
                          Tab(text: 'Info'),
                          Tab(text: 'Posts'),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Interest'),
                                Text('Groups'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Business'),
                                Text('Listings'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                const Center(child: Text('Info Content')), // Placeholder for Info tab content
                Stack(
                  children: [
                    const ListPosts(), // Posts tab content
                    Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser?.uid == uid) { //if the user is currently logged in and in their profile page show the Add Post button else in another user profile then don't show it
                          return Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255),],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const AddPosts()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent, // Set to transparent to show gradient
                                    shadowColor: Colors.transparent, // Remove default shadow
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
                          );
                        }
                        return const SizedBox.shrink(); // Return an empty widget if the condition is not met
                      },
                    ),
                  ],
                ),
                const Center(child: Text('Interest Groups Content')), // Placeholder for Interest Groups tab content
                //Center(child: Text('Business Listings Content')), // Placeholder for Business Listings tab content
                const BusinessListings(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}