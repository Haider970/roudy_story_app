import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: StoryPreviewPage(),
  ));
}

class StoryPreviewPage extends StatefulWidget {
  @override
  _StoryPreviewPageState createState() => _StoryPreviewPageState();
}

class _StoryPreviewPageState extends State<StoryPreviewPage> {
  List<String> storyImages = [
    'assets/images/barbie.png',
    'assets/images/moon.png',
    'assets/images/lion.png',
    // Add more story image paths as needed
  ];

  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to change images every 3 seconds
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % storyImages.length;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Title:The Magical Adventures of Luna and Leo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Indieflower',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // Chat Bubble 1
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(233, 224, 180, 182),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'In a cozy little town nestled at the foot of the Misty Mountains, two young friends named Luna and Leo lived right next door to each other',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              // Story Image Slideshow
              Image.asset(
                storyImages[currentIndex],
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              // Chat Bubble 2
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(233, 224, 180, 182),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Luna had long, flowing hair as dark as the night sky, and her eyes sparkled like stars. Leo, on the other hand, had wild, curly hair that seemed to mimic the golden rays of the sun, and his eyes were a warm and inviting shade of brown',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          // Back Icon
          Positioned(
            top: 30,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Navigate back to the previous screen (Story Preference Page)
              },
            ),
          ),
        ],
      ),
    );
  }
}
