import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/addpost.dart'; // Ensure this import path is correct

class PostsAndInterestGroups extends StatelessWidget {
  const PostsAndInterestGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back to the previous screen
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: Text('Posts and Interest Groups'),
          ),
          body: TabBarView(
            children: [
              Stack(
                children: [
                  // Background Container
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 0, 0), // Red
                          Color.fromARGB(255, 128, 0, 255), // Purple
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Posts Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Positioned Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Round corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'Add Post',
                          style: TextStyle(color: Colors.black), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  // Background Container
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 0, 0), // Red
                          Color.fromARGB(255, 128, 0, 255), // Purple
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Interest Groups Content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // Positioned Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddPosts()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Round corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'Add Interest Group Post',
                          style: TextStyle(color: Colors.black), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
