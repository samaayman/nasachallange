import 'package:flutter/material.dart';
import 'mission_choices_screen.dart';
import 'planet_card.dart'; // Import the PlanetCard widget
import 'planet_details_screen.dart'; // Import the details screen
import 'missions.dart'; // Import the Missions screen
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class PlanetSearchResultsScreen extends StatefulWidget {
  @override
  _PlanetSearchResultsScreenState createState() =>
      _PlanetSearchResultsScreenState();
}

class _PlanetSearchResultsScreenState extends State<PlanetSearchResultsScreen> {
  List<Map<String, String>> planets = [];
  List<Map<String, String>> filteredPlanets = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    final String csvData =
        await rootBundle.loadString('assets/nasadataset.csv');
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(csvData);

    for (var i = 1; i < rowsAsListOfValues.length; i++) {
      planets.add({
        'pl_name': rowsAsListOfValues[i][0].toString(),
        'hostname': rowsAsListOfValues[i][1].toString(),
        'sy_snum': rowsAsListOfValues[i][2].toString(),
        'sy_pnum': rowsAsListOfValues[i][3].toString(),
        'discoverymethod': rowsAsListOfValues[i][4].toString(),
        'disc_year': rowsAsListOfValues[i][5].toString(),
        'disc_facility': rowsAsListOfValues[i][6].toString(),
        'color': 'blue', // Default color for all planets
      });
    }

    setState(() {
      filteredPlanets = planets;
    });
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredPlanets = planets
          .where((planet) =>
              planet['pl_name']!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  int _currentIndex = 0; // Track the current index of the navigation bar

  // Method to handle navigation bar item taps
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/'); // Home
        break;
      case 1:
        // Navigate to Missions screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MissionChoicesScreen()), // Update this line
        ); 
        break;
      case 2:
        // Navigate to Gallery screen
        Navigator.pushNamed(context, '/gallery'); 
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Back', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results Found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Search Bar
            TextField(
              onChanged: updateSearch,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for a planet',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredPlanets.length,
                itemBuilder: (context, index) {
                  final planet = filteredPlanets[index];
                  return PlanetCard(
                    planet: planet,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }
}
