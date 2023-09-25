import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitClassScreen extends StatefulWidget {
  @override
  _ExitClassScreenState createState() => _ExitClassScreenState();
}

class _ExitClassScreenState extends State<ExitClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD7D9),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Goodbye',
                style: GoogleFonts.indieFlower(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/exit.png',
              width: 390,
              height: 700,
            ),
          ),
          Positioned(
            bottom: 300,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(231, 255, 241, 208),
                shape: BoxShape.rectangle,
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                'See you again',
                style: GoogleFonts.indieFlower(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
