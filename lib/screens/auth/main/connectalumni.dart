/*import 'package:flutter/material.dart';

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
} */

import 'package:flutter/material.dart';

class ConnectAlumni extends StatelessWidget {
  const ConnectAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)],
        ),
      ),
      child: const Center(
        child: Text(
          'ConnectAlumni and Interest Groups Content Here',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
