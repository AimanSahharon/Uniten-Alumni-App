import 'package:flutter/material.dart';

class Benefits extends StatefulWidget {
  const Benefits({super.key});

  @override
  _BenefitsState createState() => _BenefitsState();
}

class _BenefitsState extends State<Benefits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 164, 220), // Use backgroundColor instead of color
      body: const Center(
        child: Text("BENEFITS"),
      ),
    );
  }
}
