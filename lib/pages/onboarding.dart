import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:roudy_story_app/pages/sigup_page.dart';

void main() {
  runApp(MaterialApp(home: OnboardingScreen()));
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> screenTitles = [
    'Welcome to Roudy Story Box'.tr,
    'Profile Creation'.tr,
    'Feedback and Ratings'.tr,
    'Day/Night Mode'.tr
  ];

  final List<String> featureExplanations = [
    'Create personalized bedtime stories for your kids.'.tr,
    'Parents can create profiles for their children.'.tr,
    'Users can provide feedback and star ratings for the stories they read.'.tr,
    'Customize the app\'s appearance for daytime or nighttime reading.'.tr
  ];

  final List<String> imagePaths = [
    'assets/images/onb.png', // Image for screen 1
    'assets/images/anb.png', // Image for screen 2
    'assets/images/onb2.png', // Image for screen 3
    'assets/images/onb3.png', // Image for screen 4
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List locale = [
    {"name": "English(English)", "locale": Locale("en", "US")},
    {"name": "Urdu(اردو)", "locale": Locale("ur", "PK")},
    {"name": "Chinese(中文)", "locale": Locale("zh", "CN")},
  ];

  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text("Choose a language".tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      updatelanguage(locale[index]["locale"]);
                    },
                    child: Text(locale[index]["name"]), // Remove .tr here
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.amber,
                );
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: screenTitles.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return buildOnboardingPage(index);
        },
      ),
    );
  }

  Widget buildOnboardingPage(int index) {
    return Scaffold(
      backgroundColor: Color.fromARGB(233, 255, 245, 218),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePaths[index],
              width: 250,
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              screenTitles[index],
              style: TextStyle(
                fontFamily: 'IndieFlower',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              featureExplanations[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'IndieFlower',
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_currentPage == screenTitles.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(_currentPage == screenTitles.length - 1
                  ? 'Get Started'.tr
                  : 'Next'.tr),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
            SizedBox(height: 10),
            DotsIndicator(
              dotsCount: screenTitles.length,
              position: _currentPage.toInt(), // Fix here
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                activeColor: Color(0xE3D7FC),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                builddialog(context);
              },
              child: Text("Change Language".tr),
            )
          ],
        ),
      ),
    );
  }
}
