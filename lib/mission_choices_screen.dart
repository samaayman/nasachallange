import 'package:flutter/material.dart';
import 'video.dart';  // Import your video page
import 'missions.dart'; // Import your QuizPage here

class MissionChoicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Mission',style: TextStyle(color: Colors.white, fontSize: 24 , fontWeight: FontWeight.bold)),
        
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What would you like to do?',
              style: TextStyle(color: Colors.white, fontSize: 24 , fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            SizedBox
            (
              width:350,
              height:70,
              child:ElevatedButton(
              onPressed: () {
                // Navigate to the Video page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YoutubeVideoScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Updated from 'primary' to 'backgroundColor'
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text(
                'Watch Video',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),),
            SizedBox(height: 20),
            SizedBox(
            width:350,
            height:70,
            child:ElevatedButton(
              onPressed: () {
                // Navigate to the Quiz page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Updated from 'primary' to 'backgroundColor'
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text(
                'Start Quiz',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
