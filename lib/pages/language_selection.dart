import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  List<String> languages = ['English', 'Urdu', 'French'];
  String selectedLanguage = 'English';

  Map<String, String> countryFlags = {
    'English': '🇬🇧',
    'French': '🇫🇷',
    'Urdu': '🇵🇰', // Pakistan flag emoji
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: Column(
        children: [
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/lang.png', // Replace with your image
                height: 350, // Adjust the height as needed
              ),
              Positioned(
                top: 0,
                left: 0,
                child: FullCircle(),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: FullCircle(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: FullCircle(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FullCircle(),
              ),
            ],
          ),
          SizedBox(height: 20), // Add a gap between the image and the title
          Center(
            child: Text(
              'Language Selection',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLanguage = newValue;
                });
              }
            },
            items: languages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text('$value ${countryFlags[value] ?? ""}'),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle the "Back" button press
                Navigator.of(context).pop();
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                primary: Colors
                    .purple, // Set the button's background color to purple
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust the border radius to make it curved
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class FullCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30, // Diameter of the full circle
      height: 30, // Diameter of the full circle
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 248, 172, 176), // Color of the full circle
        shape: BoxShape.circle, // Make it a circle
      ),
    );
  }
}
