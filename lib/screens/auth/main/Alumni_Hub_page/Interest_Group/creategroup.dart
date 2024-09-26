//TOREAD: This is to create the group by proving group name and description as well as selecting members
import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/selectmember.dart';
import 'package:uniten_alumni_app/services/group.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController = TextEditingController(); // New controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
              ),
            ),
            TextField(
              controller: _groupDescriptionController, // New TextField for description
              decoration: const InputDecoration(
                labelText: 'Group Description', // Label for description
              ),
              maxLines: 3, // Allow multiple lines
            ),
            ElevatedButton(
              onPressed: () async {
                if (_groupNameController.text.isNotEmpty && _groupDescriptionController.text.isNotEmpty) {
                  final groupId = await GroupService().createGroup(
                    _groupNameController.text,
                    _groupDescriptionController.text, // Pass the description to the service
                  );
                  // Navigate to UserSelectionPage after creating the group
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSelectionPage(groupId: groupId),
                    ),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Group Name and Group Description cannot be empty'),
                    ),
                  );
                }
              },
              child: const Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
