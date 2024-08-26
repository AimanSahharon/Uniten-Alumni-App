import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart'; // Ensure this import path is correct

class PostsAndInterestGroups extends StatelessWidget {
  const PostsAndInterestGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController( //creating a Tab
        length: 2,
        child: Scaffold( //Creating App Bar
          appBar: AppBar(
            leading: IconButton( //Creating back button, when pressed it goes back to Alumni hub
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back to the previous screen
              },
            ),
            bottom: TabBar( //creating the tab itself
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Interest Groups'),
              ],
            ),
            title: Text('Posts and Interest Groups'), //title that will display on the app bar
          ),
          body: TabBarView(
            children: [
              //Post Tab Content
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

              //Interest Groups Tab Content
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
