import 'package:flutter/material.dart';
import 'package:roudy_story_app/pages/character_selection.dart';
import 'package:roudy_story_app/pages/chatbot_integration.dart';
import 'package:roudy_story_app/pages/community_library.dart';
import 'package:roudy_story_app/pages/language_selection.dart';
import 'package:roudy_story_app/pages/loading_page.dart';
import 'package:roudy_story_app/pages/parents_mode.dart';
import 'package:roudy_story_app/pages/personal_library.dart';
import 'package:roudy_story_app/pages/stories_prefrence.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedButton = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 20, 163, 229), Color(0xFFFFF1D0)],
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 80),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Navigate to the Story Display page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadingScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: selectedButton == 'Dashboard'
                        ? Colors.indigo
                        : Colors.purple,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Tap Here to Start a Story',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildButton('Community Library', Icons.library_books, Colors.blue,
                  () {
                // Navigate to the Community Library page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommunityLibraryPage(),
                  ),
                );
              }),
              SizedBox(height: 10),
              buildButton('Personal Library', Icons.book, Colors.green, () {
                // Implement the functionality for the Personal Library button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalLibraryPage(),
                  ),
                );
              }),
              SizedBox(height: 10),
              buildButton('Character Selection', Icons.face, Colors.orange, () {
                // Implement the functionality for the Character Selection button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterSelectionPage(),
                  ),
                );
              }),
              SizedBox(height: 10),
              buildButton('ChatBot Interaction', Icons.chat, Colors.teal, () {
                // Implement the functionality for the ChatBot Interaction button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatbotScreen(),
                  ),
                );
              }),
              SizedBox(height: 10),
              buildButton('Language', Icons.language, Colors.deepPurple, () {
                // Implement the functionality for the Language button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelectionPage(),
                  ),
                );
              }),
              SizedBox(height: 10),
              buildButton('Customize Stories', Icons.edit, Colors.red, () {
                // Implement the functionality for the Customize Stories button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryPreferencePage(),
                  ),
                );
              }),
              SizedBox(height: 20),
              Divider(),
              buildButton(
                  'Parents Mode', Icons.supervisor_account, Colors.amber, () {
                // Implement the functionality for the Parents Mode button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParentsModePage(),
                  ),
                );
              }),
              SizedBox(height: 10),
              buildButton('Exit', Icons.exit_to_app, Colors.redAccent, () {
                // Implement the functionality for the Exit button
              }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: selectedButton == text ? Colors.indigo : color,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
