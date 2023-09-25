import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roudy_story_app/pages/childern_detail.dart';
import 'package:roudy_story_app/pages/parents_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildProfile {
  final String name;
  final String imagePath;

  ChildProfile({
    required this.name,
    required this.imagePath,
  });
}

class DeleteProfilePage extends StatefulWidget {
  @override
  _DeleteProfilePageState createState() => _DeleteProfilePageState();
}

class _DeleteProfilePageState extends State<DeleteProfilePage> {
  List<ChildProfile> childProfiles = [];

  @override
  void initState() {
    super.initState();
    retrieveChildData();
  }

  Future<void> retrieveChildData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load child data from SharedPreferences
    final savedChildProfiles = prefs.getStringList('child_profiles');

    if (savedChildProfiles != null) {
      childProfiles = savedChildProfiles.map((profileString) {
        final Map<String, dynamic> profileData = json.decode(profileString);
        return ChildProfile(
          name: profileData['name'],
          imagePath: profileData['imagePath'],
        );
      }).toList();
      setState(() {});
    } else {
      // If no saved profiles, add a default profile
      addUserProfile('Default Child', 'assets/images/default_avatar.png');
    }
  }

  Future<void> saveChildProfiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final profilesToSave = childProfiles.map((profile) {
      return json.encode({
        'name': profile.name,
        'imagePath': profile.imagePath,
      });
    }).toList();
    await prefs.setStringList('child_profiles', profilesToSave);
  }

  void addUserProfile(String name, String imagePath) {
    final newProfile = ChildProfile(name: name, imagePath: imagePath);
    childProfiles.add(newProfile);
    saveChildProfiles(); // Save the updated list of profiles
    setState(() {});
  }

  void deleteChildProfile(int index) {
    childProfiles.removeAt(index);
    saveChildProfiles(); // Save the updated list of profiles after deletion
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Initialize screen_util
    ScreenUtil.init(context, designSize: Size(375, 812));

    return Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
            ),
            // Display the header image at the top
            Image.asset(
              'assets/images/prof.png', // Update with your image path
              height: 150.h, // Set the desired height
              width: 250.h, // Take the full width of the screen
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
            SizedBox(height: 20.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var index = 0; index < childProfiles.length; index++)
                  buildProfileButton(childProfiles[index].name,
                      childProfiles[index].imagePath, index),
                ElevatedButton(
                  onPressed: () {
                    // Implement the functionality to add a new profile here
                    // You can show a dialog or navigate to a profile creation page
                    // and then call addUserProfile to add the new profile
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChildDetailsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Add Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Arrange buttons evenly
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement the functionality for the Back button
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParentsModePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileButton(String label, String imagePath, int index) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.w,
          backgroundColor: Colors.transparent,
          backgroundImage: FileImage(File(imagePath)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                // Implement the functionality to delete a profile here
                deleteChildProfile(index);
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
