import 'dart:ui' as ui; // Import for image processing
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math'; // Import for generating random locations
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PlanetDetailsScreen extends StatefulWidget {
  final Map<String, String> planet;

  const PlanetDetailsScreen({required this.planet});

  @override
  _PlanetDetailsScreenState createState() => _PlanetDetailsScreenState();
}

class _PlanetDetailsScreenState extends State<PlanetDetailsScreen> {
  final List<Offset?> _points = []; // List to hold points for drawing
  final GlobalKey _globalKey = GlobalKey(); // Key for saving the image

  // Function to determine the color based on the number of stars
  Color getPlanetColor(int starCount) {
    if (starCount <= 1) {
      return Colors.red; // Color for 1 star
    } else if (starCount <= 2) {
      return Colors.orange; // Color for 2 stars
    } else if (starCount <= 3) {
      return Colors.yellow; // Color for 3 stars
    } else if (starCount <= 4) {
      return Colors.green; // Color for 4 stars
    } else {
      return Colors.blue; // Color for 5 stars
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert the star number (sy_snum) to an integer for drawing stars
    int numberOfStars = int.tryParse(widget.planet['sy_snum'] ?? '0') ?? 0;

    // Determine the planet color based on the number of stars
    Color planetColor = getPlanetColor(numberOfStars);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planet['pl_name']!), // Planet name at the top
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveToImage(), // Calls the save function
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // Capture the touch position
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            _points.add(renderBox.globalToLocal(details.globalPosition));
          });
        },
        onPanEnd: (details) {
          _points.add(null); // This signifies the end of a stroke
        },
        child: RepaintBoundary(
          key: _globalKey,
          child: Stack(
            children: [
              // Background with stars
              Positioned.fill(
                child: CustomPaint(
                  painter: StarryBackground(numberOfStars, _points), // Custom painter for stars and lines
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.planet['pl_name']!, // Display the name of the planet
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Display additional planet information
                    
                    Text(
                      'Star Number: ${widget.planet['sy_snum']}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    
                    Text(
                      'Discovery Method: ${widget.planet['discoverymethod']}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Discovery Year: ${widget.planet['disc_year']}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Discovery Facility: ${widget.planet['disc_facility']}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Spacer(),
                    // Planet image at the bottom with dynamic color
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: planetColor, // Set color based on star number
                            boxShadow: [
                              BoxShadow(
                                color: planetColor.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          width: 120,
                          height: 120,
                        ),
                        Image.asset(
                          'assets/Mercury.png', // Replace with actual planet image
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Future<void> _saveToImage() async {
    try {
      // Capture the widget as an image
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/planet_image.png');

      // Save the image
      await file.writeAsBytes(pngBytes);
      print('Image saved to ${file.path}'); // Print path for verification

      // Optionally, you can show a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image saved to ${file.path}'),
      ));
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving image.'),
      ));
    }
  }
}

// Custom Painter for drawing stars (white dots) and user-drawn lines
class StarryBackground extends CustomPainter {
  final int numberOfStars;
  final List<Offset?> points;
  final Random random = Random();

  StarryBackground(this.numberOfStars, this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint starPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10; // Increase the stroke width for bigger stars

    // Draw stars at random positions
    for (int i = 0; i < numberOfStars; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 10, starPaint); // Increase the radius for bigger stars
    }

    final Paint linePaint = Paint()
      ..color = Colors.red // Color for the user's drawing
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4; // Width of the user's drawing

    // Draw the user's points
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever the points change
  }
}
