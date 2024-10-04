import 'package:flutter/material.dart';
import 'Video.dart'; // Import the YouTube video screen page
import 'mission_choices_screen.dart';
import 'missions.dart'; // Import the MissionChoicesScreen page

class ConstellationPreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'My Constellations',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: Column(
        children: [
          // Background Image of the Planet
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'), // Ensure this image exists
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Quick Video Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Navigate to YouTube Video Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YoutubeVideoScreen()),
                );
              },
              child: Text(
                'Quick Video',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),

          // Add to Gallery Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Navigate to Gallery when Add to Gallery is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              },
              child: Text(
                'Add to Gallery',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Navigate to the MissionChoicesScreen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MissionChoicesScreen()),
                );
              },
              child: Icon(Icons.explore, color: Colors.white),
            ),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.image, color: Colors.white),
              onPressed: () {
                // Make the Gallery icon clickable
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              },
            ),
            label: 'Gallery',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Gallery', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          'Gallery Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
