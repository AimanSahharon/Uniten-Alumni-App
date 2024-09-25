//TOREAD: This file is to display all users to the curretly logged in user
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/profile.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  @override
  Widget build(BuildContext context) {
    // Fetch the list of users from the provider
    final users = Provider.of<List<UserModel>>(context) ?? [];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        
        // Navigate to the profile page when an item is tapped
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Profile(uid: user.id,), // Pass the selected user's ID
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    user.profileImageUrl.isNotEmpty //if user's image is not empty then display their profile pic along with their name
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(user.profileImageUrl),
                        )
                      : const Icon(Icons.person, size: 40),
                    const SizedBox(width: 10),
                    Text(user.name),
                  ],
                ),
              ),
              const Divider(thickness: 1),
            ],
          ),
        );
      },
    );
  }
}
