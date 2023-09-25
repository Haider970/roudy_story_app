import 'package:flutter/material.dart';
import 'package:roudy_story_app/pages/preview_story.dart';

class StoryPreferencePage extends StatefulWidget {
  @override
  _StoryPreferencePageState createState() => _StoryPreferencePageState();
}

class _StoryPreferencePageState extends State<StoryPreferencePage> {
  List<String> themes = ['Theme 1', 'Theme 2', 'Theme 3'];
  List<String> storyPreferences = [
    'Preference 1',
    'Preference 2',
    'Preference 3'
  ];
  String selectedTheme = 'Theme 1';
  String selectedStoryPreference = 'Preference 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/lion.png', // Replace with your image asset
                  height: 380, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Story Title',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IndieFlower',
                    color: Colors.black, // Text color
                  ),
                ),
              ),

              // Select Your Theme Dropdown
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: DropdownButton<String>(
                  value: selectedTheme,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedTheme = newValue;
                      });
                    }
                  },
                  items: themes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.black, // Text color of the dropdown
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Select Story Preference Dropdown
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: DropdownButton<String>(
                  value: selectedStoryPreference,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedStoryPreference = newValue;
                      });
                    }
                  },
                  items: storyPreferences
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.black, // Text color of the dropdown
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Preview Story Button (Same size as dropdowns)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the Preview Story page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryPreviewPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Preview Story',
                    style: TextStyle(
                      color: Colors.black, // Text color of the button
                    ),
                  ),
                ),
              ),
              // Back Button
              TextButton(
                onPressed: () {
                  // Handle back button press
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color of the button
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -30,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  height: 50, // Adjust the height of half circles
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Color of the half circle
                  ),
                ),
                Container(
                  width: 50,
                  height: 50, // Adjust the height of half circles
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Color of the half circle
                  ),
                ),
                Container(
                  width: 50,
                  height: 50, // Adjust the height of half circles
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Color of the half circle
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
