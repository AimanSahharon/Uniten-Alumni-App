import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
//import 'package:uniten_alumni_app/screens/auth/main/home.dart';
import 'package:uniten_alumni_app/screens/auth/main/navmenu.dart';
import 'package:uniten_alumni_app/screens/auth/main/post.dart';
import 'package:uniten_alumni_app/screens/auth/signup.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    print(user);
    if (user == null) {
      return SignUp(); // Or any other appropriate screen for non-authenticated users
    } else {

      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => NavMenu(),
          '/post' : (context) => Posts(),
        }
      );
      //return NavMenu(); // Show main system routes
    }
  }
    //return Home();
  }
