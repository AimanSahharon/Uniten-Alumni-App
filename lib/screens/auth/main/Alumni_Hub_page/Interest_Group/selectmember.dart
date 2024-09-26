//TOREAD: This page is to allow user to select which alumni can be part of the group and to members perspective the created groups will be in My Interest Group tab
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/interestgroup.dart';
import 'package:uniten_alumni_app/services/user.dart'; // Ensure you have this service for querying users

class UserSelectionPage extends StatefulWidget {
  final String groupId;

  const UserSelectionPage({super.key, required this.groupId});

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();
  final List<String> _selectedUserIds = [];
  List<UserModel> _users = [];
  String search = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get(); // Fetch all users
    setState(() {
      _users = querySnapshot.docs.map((doc) {
        return UserModel(
          id: doc.id,
          name: doc['name'],
          profilePicture: doc['profileImageUrl'], // Add this line
        );
      }).toList();
    });
  }

  void _toggleUserSelection(String userId) {
    setState(() {
      if (_selectedUserIds.contains(userId)) {
        _selectedUserIds.remove(userId);
      } else {
        _selectedUserIds.add(userId);
      }
    });
  }

  Future<void> _addUsersToGroup() async {
    // Add selected users to group members
    await _firestore.collection('groups').doc(widget.groupId).update({
      'members': FieldValue.arrayUnion(_selectedUserIds),
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InterestGroup(),
      ),
    ); // Go back after adding users
  }

  @override
  Widget build(BuildContext context) {
    // Filter users based on the search query
    final filteredUsers = _users.where((user) => user.name.toLowerCase().contains(search.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _addUsersToGroup();
            },
          ),
        ],
      ),
      body: Column(
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
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePicture), // Display the profile picture
                      ),
                      title: Text(user.name),
                      trailing: Checkbox(
                        value: _selectedUserIds.contains(user.id),
                        onChanged: (bool? value) {
                          _toggleUserSelection(user.id);
                        },
                      ),
                      onTap: () {
                        _toggleUserSelection(user.id);
                      },
                    ),
                    const Divider(), // Add a divider below each ListTile
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String profilePicture; // Add this field

  UserModel({required this.id, required this.name, required this.profilePicture}); // Update the constructor
}
