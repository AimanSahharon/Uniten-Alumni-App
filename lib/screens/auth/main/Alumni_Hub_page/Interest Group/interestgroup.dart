import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest%20Group/creategroup.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest%20Group/grouppage.dart'; // Ensure GroupDetailsPage is imported
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest%20Group/list_created_group.dart';
import 'package:uniten_alumni_app/services/group.dart';
import 'package:uniten_alumni_app/models/group.dart';
import 'package:uniten_alumni_app/models/grouppost.dart';

class InterestGroup extends StatefulWidget {
  const InterestGroup({super.key});

  @override
  State<InterestGroup> createState() => _InterestGroupState();
}

class _InterestGroupState extends State<InterestGroup> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Interest Group'),
              Tab(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('My'), Text('Interest Group')])),
              Tab(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Created'), Text('Interest Groups')])),
            ],
          ),
          title: const Text('Interest Groups'),
        ),
        body: TabBarView(
          children: [
            _buildGroupListTab(),
            _buildJoinedGroupsTab(),
            _buildCreatedGroupsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 255, 0, 0),
            Color.fromARGB(255, 128, 0, 255),
          ],
        ),
      ),
    );
  }

  // Pull-to-refresh for all groups
  Widget _buildGroupListTab() {
    return Stack(
      children: [
        _buildBackgroundGradient(),
        RefreshIndicator(
          onRefresh: _refreshGroups,
          child: Column(
            children: [
              Expanded(
                child: _buildGroupList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupList() {
    return FutureBuilder<List<GroupModel>>(
      future: GroupService().getAllGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading group posts'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No group posts available'));
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

  // Pull-to-refresh for joined groups
  Widget _buildJoinedGroupsTab() {
    return Stack(
      children: [
        _buildBackgroundGradient(),
        RefreshIndicator(
          onRefresh: _refreshJoinedGroups,
          child: Column(
            children: [
              Expanded(
                child: _buildJoinedGroupsList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJoinedGroupsList() {
    return FutureBuilder<List<GroupModel>>(
      future: GroupService().getJoinedGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
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

  // Pull-to-refresh for created groups
  Widget _buildCreatedGroupsTab() {
    return Stack(
      children: [
        _buildBackgroundGradient(),
        RefreshIndicator(
          onRefresh: _refreshCreatedGroups,
          child: Column(
            children: [
              Expanded(
                child: ListGroup(), // Assuming this is your ListGroup widget
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildCreateNewGroupButton(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Method to refresh all groups
  Future<void> _refreshGroups() async {
    setState(() {
      // Trigger rebuild to fetch new data
    });
  }

  // Method to refresh joined groups
  Future<void> _refreshJoinedGroups() async {
    setState(() {
      // Trigger rebuild to fetch new data
    });
  }

  // Method to refresh created groups
  Future<void> _refreshCreatedGroups() async {
    setState(() {
      // Trigger rebuild to fetch new data
    });
  }

  Widget _buildCreateNewGroupButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 255, 0, 0),
            Color.fromARGB(255, 128, 0, 255),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateGroupPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: const Text(
          'Create New Group',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

