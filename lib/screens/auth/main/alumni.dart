import 'package:flutter/material.dart';

class Alumni extends StatefulWidget {
  const Alumni({super.key});

  @override
  _AlumniState createState() => _AlumniState();
}

class _AlumniState extends State<Alumni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 210, 97), // Use backgroundColor instead of color
      body: const Center(
        child: Text("Alumni"),
      ),
    );
  }
}
