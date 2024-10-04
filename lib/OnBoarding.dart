import 'package:flutter/material.dart';

import 'Search.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the device's screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onB.png'), // Replace with your actual image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, // Adjust padding based on screen width
              vertical: screenHeight * 0.05,  // Adjust padding based on screen height
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and Title back to the top
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/coconut 1.png', // Replace with your logo
                        height: screenHeight * 0.05, // Adjust logo size
                      ),
                      SizedBox(width: screenWidth * 0.02), // Spacing between logo and title
                      Text(
                        'StarMap Voygar', // App title next to the logo
                        style: TextStyle(
                          fontSize: screenWidth * 0.03, // Adjust font size of the title
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.08), // Adjust spacing after logo

                // Centered text section
                Spacer(), // Pushes the text down
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'START YOUR COSMIC JOURNEY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.08, // Adjust font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Choose a planet, explore its stars, and create your own constellations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Adjust subtitle size
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Spacer(), // Pushes the button down

                // Get Started Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Define button action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlanetExplorerApp(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                      ), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05, // Adjust button text size
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
