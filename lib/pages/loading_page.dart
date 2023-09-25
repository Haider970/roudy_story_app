import 'package:flutter/material.dart';
import 'package:roudy_story_app/pages/story_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay using a Future
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the StoryDisplayPage after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => StoryDisplayPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(241, 255, 245, 218),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Image.asset('assets/images/load.png'),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(226, 197, 173, 248)),
              strokeWidth: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
