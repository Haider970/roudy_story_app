import 'package:flutter/material.dart';
import 'package:roudy_story_app/pages/stories_prefrence.dart';
// Import the Customize Stories page

class PersonalLibraryPage extends StatelessWidget {
  final List<String> itemImages = [
    'assets/images/cas.png',
    'assets/images/dino.png',
    'assets/images/mag.png',
    'assets/images/moon.png',
    // Add more item image paths
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFFFF1D0), // Set your desired background color
              height: 250.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/per.png',
                    height: 250.0,
                    width: 250.0,
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      'Personal Library',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IndieFlower',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.0),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.0, // Adjust this value to your preference
              ),
              itemCount: itemImages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    itemImages[index],
                    fit: BoxFit.cover, // Adjust the fit mode as needed
                    width: 50.0, // Set the desired width
                    height: 50.0, // Set the desired height
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Customize Stories page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoryPreferencePage()),
                    );
                  },
                  child: Text('Customize Stories'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE3D7FC),
                  ),
                )
              ],
            ),
            SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the dashboard
                Navigator.pop(context);
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE3D7FC), // Set the desired background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
