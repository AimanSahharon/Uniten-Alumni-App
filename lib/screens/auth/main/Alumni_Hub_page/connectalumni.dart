//TOREAD: This is Connect Alumni page to display all the user's profile to the currently logged in user

import 'package:firebase_auth/firebase_auth.dart';
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
