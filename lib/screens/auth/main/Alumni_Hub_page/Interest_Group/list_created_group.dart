// This is to list groups based on created groups by the user which will be passed in interestgroup.dart
import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/models/group.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/grouppage.dart';
import 'package:uniten_alumni_app/services/group.dart';

class ListGroup extends StatelessWidget {
  const ListGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GroupModel>>(
      future: GroupService().getCreatedGroups(), // Fetch created groups from GroupService
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading created groups'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No created groups available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final group = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    group.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Leader: ${group.leader}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GroupDetailsPage(group: group),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );

    
  }
}
