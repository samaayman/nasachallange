import 'package:flutter/material.dart';
import 'planet_search_results_screen.dart';

void main() {
  runApp(const PlanetExplorerApp());
}

class PlanetExplorerApp extends StatelessWidget {
  const PlanetExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planet Explorer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const PlanetSearchScreen(),
    );
  }
}

class PlanetSearchScreen extends StatefulWidget {
  const PlanetSearchScreen({super.key});

  @override
  _PlanetSearchScreenState createState() => _PlanetSearchScreenState();
}

class _PlanetSearchScreenState extends State<PlanetSearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png', // Add your background image here
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/coconut 1.png',
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      'StarMap Voyager',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  'Hey Explorer!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Let\'s \nExplore \nThe Universe',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the results screen showing all planets
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PlanetSearchResultsScreen(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, 
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Explore Planets', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),

                // Star Color Legend
                const Text(
                  'Star of planets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStarLegend(1, Colors.red),
                    _buildStarLegend(2, Colors.orange),
                    _buildStarLegend(3, Colors.yellow),
                    _buildStarLegend(4, Colors.green),
                    _buildStarLegend(5, Colors.blue)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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

  // Widget to build the star legend
  Widget _buildStarLegend(int starCount, Color color) {
    return Row(
      children: [
        Icon(Icons.star, color: color),
        const SizedBox(width: 2),
        Text('$starCount star${starCount > 1 ? 's' : ''}', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
