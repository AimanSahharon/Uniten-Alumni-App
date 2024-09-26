import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/models/group.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/grouppage.dart';
import 'package:uniten_alumni_app/services/group.dart';

class JoinedGroup extends StatefulWidget {
  final String uid; // Add this line

  const JoinedGroup({super.key, required this.uid}); // Update the constructor

  @override
  State<JoinedGroup> createState() => _JoinedGroupState();
}

class _JoinedGroupState extends State<JoinedGroup> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GroupModel>>(
      future: GroupService().getJoinedGroups(widget.uid), // Pass the UID here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Center(child: Text('Error loading joined groups'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No joined groups available'));
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
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
