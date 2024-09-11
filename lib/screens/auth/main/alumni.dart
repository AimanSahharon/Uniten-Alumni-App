/*import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/posts.dart';

class Alumni extends StatefulWidget {
  const Alumni({super.key});

  @override
  _AlumniState createState() => _AlumniState();
}

class _AlumniState extends State<Alumni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromARGB(255, 27, 210, 97),
      body:  Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], // enable gradient color on the background
          )
        ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Add the "Alumni Hub" text above the white box
            Text(
              'Alumni Hub',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              ),
          ],
          )
        
        
        Container(
      width: 350.0,
      height: 500.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      /*child: const Center(
            child: Text("Alumni"),
            //ElevatedButton()

          ), */
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildAlumniButton('Connect Alumni', Colors.red, Colors.purple),
              buildAlumniButton('Posts and Interest Groups', Colors.red, Colors.purple),
              buildAlumniButton('UNITEN Alumni Business Listings', Colors.red, Colors.purple),
              buildAlumniButton('My Interest Groups', Colors.red, Colors.purple),
            ],
          ),
        )
        ),
      ),
    )
    );
  }
  Widget buildAlumniButton(String text, Color startColor, Color endColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            ),
            borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
             ),
            ),
            onTap: () {
               if (text == 'Connect Alumni') {
              // Navigate to PostPage when this button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyCard()),
              );
            }


               if (text == 'Posts and Interest Groups') {
              // Navigate to PostPage when this button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Posts()),
              );
            }

            

          } 
        ),
      )
    );
  }


} */


//TOREAD: This is Alumni page or Alumni hub which is a menu for user to go to other pages
import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/business_listings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/posts_and_interest_groups.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/feed.dart';

class Alumni extends StatefulWidget {
  const Alumni({super.key});

  @override
  _AlumniState createState() => _AlumniState();
}

class _AlumniState extends State<Alumni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 27, 210, 97),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 128, 0, 255)
            ], // enable gradient color on the background
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add the "Alumni Hub" text above the white box
              const Text(
                'Alumni Hub',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0, // Adjust the size as needed
                ),
              ),
              const SizedBox(height: 20.0), // Space between text and the white box
              Container(
                width: 350.0,
                height: 320.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildAlumniButton('Connect Alumni', Colors.red, Colors.purple),
                      buildAlumniButton('Posts and Interest Groups', Colors.red, Colors.purple),
                      buildAlumniButton('UNITEN Alumni Business Listings', Colors.red, Colors.purple),
                      buildAlumniButton('My Interest Groups', Colors.red, Colors.purple),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAlumniButton(String text, Color startColor, Color endColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          title: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () { //when user tap on one of the button, go to different pages
            if (text == 'Connect Alumni') {
              // Navigate to MyCard when this button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConnectAlumni()),
              );
            }

            if (text == 'Posts and Interest Groups') {
              // Navigate to Posts when this button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostsAndInterestGroups()),//PostsAndInterestGroups()),
              );
            
            }

            if (text == 'UNITEN Alumni Business Listings') {
              // Navigate to Posts when this button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BusinessListingsPage()),//PostsAndInterestGroups()),
              );
            
            }
          },
        ),
      ),
    );
  }
}
