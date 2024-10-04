import 'package:flutter/material.dart';
import 'OnBoarding.dart'; // Import the separate page file

void main() {
  runApp(const SpaceCoconutsApp());
}

class SpaceCoconutsApp extends StatelessWidget {
  const SpaceCoconutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoarding(), // This points to the separated page widget
    );
  }
}
