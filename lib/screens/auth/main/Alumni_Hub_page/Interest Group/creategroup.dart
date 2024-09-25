import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest%20Group/selectmember.dart';
import 'package:uniten_alumni_app/services/group.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();

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
            ElevatedButton(
              onPressed: () async {
                if (_groupNameController.text.isNotEmpty) {
                  final groupId = await GroupService().createGroup(_groupNameController.text);
                  // Navigate to UserSelectionPage after creating the group
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSelectionPage(groupId: groupId),
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
