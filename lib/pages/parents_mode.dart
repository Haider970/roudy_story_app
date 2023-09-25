import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roudy_story_app/pages/childern_detail.dart';
import 'package:roudy_story_app/pages/dashboard_page.dart';
import 'package:roudy_story_app/pages/delete_profile.dart';
import 'package:roudy_story_app/pages/exit.dart';
import 'package:roudy_story_app/pages/feedback_rating.dart';
import 'package:roudy_story_app/pages/pricing_plan.dart'; // Import screen_util

class ParentsModePage extends StatefulWidget {
  @override
  _ParentsModePageState createState() => _ParentsModePageState();
}

class _ParentsModePageState extends State<ParentsModePage> {
  String selectedButton = 'Parents Mode';

  @override
  Widget build(BuildContext context) {
    // Initialize screen_util
    ScreenUtil.init(context, designSize: Size(375, 812));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 20, 163, 229),
              Color(0xFFFFF1D0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h), // Use screen_util for height
                Text(
                  'Parents Mode',
                  style: TextStyle(
                    fontSize: 24.sp, // Use screen_util for font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.h), // Use screen_util for height
                Container(
                  width: 150.w, // Use screen_util for width
                  height: 150.h, // Use screen_util for height
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/par.png'), // Replace with your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Use screen_util for height
                buildButton('New Profile', Icons.person_add, Colors.blue, () {
                  // Implement the functionality for the New Profile button
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ChildDetailsPage(),
                  //   ),
                  // );
                }),
                SizedBox(height: 10.h), // Use screen_util for height
                buildButton('Delete Profile', Icons.delete, Colors.red, () {
                  // Implement the functionality for the Delete Profile button
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteProfilePage(),
                    ),
                  );
                }),
                SizedBox(height: 10.h), // Use screen_util for height
                buildButton('Dark Mode', Icons.dark_mode, Colors.grey, () {
                  // Implement the functionality for the Dark Mode button
                }),
                SizedBox(height: 10.h), // Use screen_util for height
                buildButton('Feedback & Rating', Icons.star, Colors.yellow, () {
                  // Implement the functionality for the Feedback & Rating button
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackRatingPage(),
                    ),
                  );
                }),
                SizedBox(height: 10.h), // Use screen_util for height
                buildButton('Pricing Plan', Icons.attach_money, Colors.green,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PricingPage(),
                    ),
                  );
                  // Implement the functionality for the Pricing Plan button
                }),
                SizedBox(height: 10.h), // Use screen_util for height
                buildButton('Logout', Icons.logout, Colors.red, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExitClassScreen(),
                    ),
                  );
                  // Implement the functionality for the Logout button
                }),
                SizedBox(height: 20.h), // Use screen_util for height
                buildButton('Dashboard', Icons.dashboard, Colors.purple, () {
                  // Implement the functionality for the Dashboard button
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                }),
                SizedBox(height: 20.h), // Use screen_util for height
                buildButton('Exit', Icons.exit_to_app,
                    const Color.fromARGB(255, 82, 255, 169), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExitClassScreen(),
                    ),
                  );
                  // Implement the functionality for the Exit button
                }),
                SizedBox(height: 20.h), // Use screen_util for height
              ],
            ),
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
        padding: EdgeInsets.all(15.w), // Use screen_util for padding
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.w), // Use screen_util for borderRadius
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40.sp, // Use screen_util for icon size
            color: Colors.white,
          ),
          SizedBox(height: 10.h), // Use screen_util for height
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp, // Use screen_util for font size
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
