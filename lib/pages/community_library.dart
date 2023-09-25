import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CommunityLibraryPage extends StatefulWidget {
  @override
  _CommunityLibraryPageState createState() => _CommunityLibraryPageState();
}

class _CommunityLibraryPageState extends State<CommunityLibraryPage> {
  int _currentIndex = 0;

  List<String> storyImages = ['grad', 'camel', 'mob'];
  List<String> storyTitles = ['Grad Story', 'Camel Story', 'Mob Story'];

  void _showImageDialog(String imageName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.asset(
            'assets/images/$imageName.png',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image before the title
            Image.asset(
              'assets/images/com.png', // Replace with your image path
              height: 250.0,
              width: 250.0,
            ),
            SizedBox(height: 5.0),
            Text(
              'Community Library',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            CarouselSlider(
              items: storyImages.map((imageName) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/images/$imageName.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.read_more),
                                onPressed: () {
                                  _showImageDialog(imageName);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.save),
                                onPressed: () {
                                  // Implement your save logic here
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 300.0,
                initialPage: _currentIndex,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: storyImages.map((image) {
                int index = storyImages.indexOf(image);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the dashboard
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
