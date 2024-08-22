import 'package:flutter/material.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  State<ConnectAlumni> createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {
  @override
  Widget build(BuildContext context) {
   return const Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 151, 14), // Use backgroundColor instead of color
      body: Center(
        child: Text("Connect Alumni"),
      ),
    );
  }
}