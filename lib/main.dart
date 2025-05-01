import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const Lab7());
}

class Lab7 extends StatelessWidget {
  const Lab7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAB 07',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Updated primary swatch for better aesthetics
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ListViewBuilder(),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    required this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo, // Use the same tag here as in the ListView item for animation
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 50.0; // Slow down animations for easier viewing

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // Cool color for AppBar
        title: const Text('Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'https://townsquare.media/site/442/files/2013/06/Man-of-Steel-Concept-Art-1.jpg', // URL of the image
          width: 300, // Larger width to showcase the hero transition
          onTap: () {
            Navigator.of(context).pop(); // Close the screen on tap
          },
        ),
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // Matching AppBar color
        title: const Text('List View Builder'),
      ),
      body: Container(
        color: Colors.blueGrey.shade50, // Light background color for the body
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            String imagePath = 'https://townsquare.media/site/442/files/2013/06/Man-of-Steel-Concept-Art-1.jpg'; // URL of the image
            return AnimatedPadding(
              duration: const Duration(milliseconds: 600), // Slower padding animation (increased duration)
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.blue.shade50, // A cool blue card background
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(Icons.account_box, color: Colors.deepPurple), // Cool icon color
                  title: Text("List item $index", style: const TextStyle(color: Colors.deepPurple)),
                  trailing: SizedBox(
                    width: 50,
                    height: 50,
                    child: Hero(
                      tag: imagePath, // Use the same tag for the Hero animation
                      child: InkWell(
                        onTap: () {
                          // Navigate to the HeroAnimation screen when the image is tapped
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (context) {
                              return const HeroAnimation();
                            },
                          ));
                        },
                        child: Image.network(
                          imagePath, // The same URL for the image
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
