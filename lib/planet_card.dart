import 'package:flutter/material.dart';
import 'planet_details_screen.dart'; // Import the details screen

class PlanetCard extends StatelessWidget {
  final Map<String, String> planet;

  const PlanetCard({
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanetDetailsScreen(planet: planet),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColor(planet['sy_snum']), // Pass star number to getColor
                    boxShadow: [
                      BoxShadow(
                        color: getColor(planet['sy_snum']).withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  width: 80,
                  height: 80,
                ),
                Image.asset(
                  'assets/Mercury.png', // Replace with actual image file
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              planet['pl_name']!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String? starCount) {
    // Check if starCount is null or not a valid integer
    if (starCount == null) {
      return Colors.white; // Default color
    }

    // Parse the star count
    int stars = int.tryParse(starCount) ?? 0;

    switch (stars) {
      case 1:
        return Colors.red; // 1 star
      case 2:
        return Colors.orange; // 2 stars
      case 3:
        return Colors.yellow; // 3 stars
      case 4:
        return Colors.green; // 4 stars
      case 5:
        return Colors.blue; // 5 stars
      default:
        return Colors.white; // Default for any other case
    }
  }
}
