/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/connectalumni.dart';
//import 'package:uniten_alumni_app/screens/auth/main/home.dart';
import 'package:uniten_alumni_app/screens/auth/main/navmenu.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/edit_profile.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/profile.dart';
import 'package:uniten_alumni_app/screens/auth/signup.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    /*if (user == null) {
      return const SignUp(); // Show SignUp screen if user is not authenticated
    } else {
      return  NavMenu(); // Show NavMenu if user is authenticated
    } */

    print(user);
    if (user == null) {
      return SignUp(); // Or any other appropriate screen for non-authenticated users
    } else {

      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => const NavMenu(),
          '/addpost' : (context) => AddPosts(),
          '/connectalumni' : (context) => const ConnectAlumni(),
          '/profile' : (context) => const Profile(uid: FirebaseAuth.instance.currentUser!.uid)),
          '/editprofile' : (context) => const EditProfile(),
        }
      ); 
    } 
  }

  } */


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/feed.dart';
import 'package:uniten_alumni_app/screens/auth/main/navmenu.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/edit_profile.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/profile.dart';
import 'package:uniten_alumni_app/screens/auth/signup.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return const SignUp(); // Show SignUp screen if user is not authenticated
    } else {
      return NavMenu(); // Show NavMenu if user is authenticated
    }
  }
}


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Wrapper(), // Use Wrapper as the root widget
      '/addpost': (context) => AddPosts(),
      '/connectalumni': (context) =>  ConnectAlumni(),
      // You should handle `uid` in profile route properly
      '/profile': (context) {
        final user = Provider.of<UserModel>(context, listen: false);
        return Profile(uid: user.id); // Pass the user UID here
            },
      '/editprofile': (context) => const EditProfile(),
      '/feed': (context) => const Feed(),
    },
  ));
} 
