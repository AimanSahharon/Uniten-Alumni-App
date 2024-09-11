/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/wrapper.dart';
import 'package:uniten_alumni_app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel?>.value(
            value: AuthService().user,
            initialData: null,
            child: MaterialApp(home: Wrapper()),
            );
          
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("Loading");
      },
    );
  }
} */

/*
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/wrapper.dart';
import 'package:uniten_alumni_app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel?>.value(
            value: AuthService().user,
            initialData: null,
            child: const MaterialApp(home: Wrapper()),
            );
          
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text("Loading");
      },
    );
  }
} */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/wrapper.dart';
import 'package:uniten_alumni_app/services/auth.dart';
import 'firebase_options.dart'; // Import the generated Firebase options file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the appropriate platform options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(home: Wrapper()),
    );
  }
} 

