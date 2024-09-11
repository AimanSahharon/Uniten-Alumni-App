/*
import 'package:flutter/material.dart';

class ConnectAlumni extends StatelessWidget {
  const ConnectAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( //to contain all the elements similar the div for web development
      decoration: const BoxDecoration( //to decorate the background color
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], //to enable gradient color on the background
        ), 
      ),
      child: const Center(
        child: Text(
          'Connect Alumni',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} */
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/listprofile.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  State<ConnectAlumni> createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {

  UserService _userService = UserService();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _userService.queryByName(search),
      initialData: [],
      child: Column(children: [
        Padding(padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            setState(() {
              search = text;
            });
          },
          decoration: InputDecoration(hintText: 'Search...'),
        ),
      ),
        ListUsers()
    ],
  ),
 );
  }
} 
*/
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/listprofile.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  State<ConnectAlumni> createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {

  UserService _userService = UserService();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _userService.queryByName(search),
      initialData: [],
      child: Column(children: [
        Padding(padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            setState(() {
              search = text;
            });
          },
          decoration: InputDecoration(hintText: 'Search...'),
        ),
      ),
        ListUsers()
    ],
  ),
 );
  }
} */
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/listprofile.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  State<ConnectAlumni> createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {

  UserService _userService = UserService();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _userService.queryByName(search),
      initialData: [],
      child: Column(children: [
        Padding(padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            setState(() {
              search = text;
            });
          },
          decoration: InputDecoration(hintText: 'Search...'),
        ),
      ),
        ListUsers()
    ],
  ),
 );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/listprofile.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  State<ConnectAlumni> createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {

  UserService _userService = UserService();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _userService.queryByName(search),
      initialData: [],
      child: Column(children: [
        Padding(padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (text) {
            setState(() {
              search = text;
            });
          },
          decoration: const InputDecoration(hintText: 'Search...'),
        ),
      ),
        const ListUsers()
    ],
  ),
 );
  }
} */

/*Able to search but only show name and when pressed on it it doesn't show the post

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectAlumni extends StatefulWidget {
  @override
  _ConnectAlumniState createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _users = [];
  List<DocumentSnapshot> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _users = snapshot.docs;
      _filteredUsers = _users;
    });
  }

  void _filterUsers(String query) {
    final filteredUsers = _users.where((user) {
      final name = user['name'].toString().toLowerCase();
      final searchTerm = query.toLowerCase();
      return name.contains(searchTerm);
    }).toList();

    setState(() {
      _filteredUsers = filteredUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect Alumni'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search by name',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                final name = user['name'] ?? 'No name';

                return ListTile(
                  title: Text(name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(userId: user.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final String userId;

  UserProfilePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('User not found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final name = userData['name'] ?? 'No name';
          final posts = userData['posts'] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ListTile(
                      title: Text(post['title'] ?? 'No title'),
                      subtitle: Text(post['content'] ?? 'No content'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} */

//TOREAD: This is Connect Alumni page to display all the user's profile to the currently logged in user

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/listprofile.dart';
import 'package:uniten_alumni_app/services/user.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  State<ConnectAlumni> createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {
  final UserService _userService = UserService();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Alumni'),
      ),
      body: StreamProvider<List<UserModel>>.value(
        value: _userService.queryByName(search),
        initialData: const [],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    search = text;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Expanded(child: ListUsers()), // display the user using listprofile.dart in Profile folder
          ],
        ),
      ),
    );
  }
}
