import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/services/group.dart';
import 'package:uniten_alumni_app/models/group.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupModel group;

  const GroupDetailsPage({required this.group, Key? key}) : super(key: key);

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  bool _isMember = false;
  bool _isOwner = false;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  void _checkUserRole() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _isOwner = widget.group.leader == currentUser.uid;
        _isMember = widget.group.members.contains(currentUser.uid);
      });
    }
  }

  Future<void> _joinGroup() async {
    await GroupService().joinGroup(widget.group.id);
    setState(() {
      _isMember = true;
    });
  }

  Future<void> _leaveGroup() async {
    await GroupService().leaveGroup(widget.group.id);
    setState(() {
      _isMember = false;
    });
  }

  Future<void> _editGroup() async {
    // Logic for editing the group (navigate to edit page or show form)
  }

  Future<void> _deleteGroup() async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Group'),
          content: const Text('Are you sure you want to delete this group?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      await GroupService().deleteGroup(widget.group.id); // Add this method in your GroupService
      Navigator.of(context).pop(); // Optionally pop the page after deletion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Group Leader: ${widget.group.leader}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_isOwner)
              ElevatedButton(
                onPressed: _deleteGroup,
                child: const Text('Delete Group'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Optional styling
              ),
            _isOwner
                ? ElevatedButton(
                    onPressed: _editGroup,
                    child: const Text('Edit Group'),
                  )
                : _isMember
                    ? ElevatedButton(
                        onPressed: _leaveGroup,
                        child: const Text('Leave Group'),
                      )
                    : ElevatedButton(
                        onPressed: _joinGroup,
                        child: const Text('Join Group'),
                      ),
          ],
        ),
      ),
    );
  }
}
