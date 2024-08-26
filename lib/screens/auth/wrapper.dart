import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/connectalumni.dart';
//import 'package:uniten_alumni_app/screens/auth/main/home.dart';
import 'package:uniten_alumni_app/screens/auth/main/navmenu.dart';
import 'package:uniten_alumni_app/screens/auth/main/posts.dart';
import 'package:uniten_alumni_app/screens/auth/signup.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return const SignUp(); // Show SignUp screen if user is not authenticated
    } else {
      return  NavMenu(); // Show NavMenu if user is authenticated
    } 

    /*print(user);
    if (user == null) {
      return SignUp(); // Or any other appropriate screen for non-authenticated users
    } else {

      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => const NavMenu(),
          '/post' : (context) => Posts(),
          '/connectalumni' : (context) => const ConnectAlumni(),
        }
      ); 
    } */
  }

  }
