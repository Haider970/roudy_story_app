import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roudy_story_app/pages/childern_detail.dart';
import 'package:roudy_story_app/pages/parents_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  ChildProfile? selectedChild; // Store the selected child

  @override
  void initState() {
    super.initState();
    // Fetch child profiles from Firebase Firestore
    fetchChildProfiles();
  }

  Future<void> fetchChildProfiles() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('child_profiles').get();

      final List<ChildProfile> profiles = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ChildProfile(
          name: data['name'] ?? '',
          imagePath: data['imagePath'] ?? '',
        );
      }).toList();

      setState(() {
        childProfiles = profiles;
        // Select the first child as the default
        if (childProfiles.isNotEmpty) {
          selectedChild = childProfiles[0];
        }
      });
    } catch (e) {
      print('Error fetching child profiles: $e');
    }
  }

  void addUserProfile(String name, String imagePath) {
    final newProfile = ChildProfile(name: name, imagePath: imagePath);
    childProfiles.add(newProfile);
    setState(() {
      selectedChild = newProfile; // Select the newly added child
    });
  }

  void deleteChildProfile(int index) {
    childProfiles.removeAt(index);
    setState(() {
      // Select the first child if available
      if (childProfiles.isNotEmpty) {
        selectedChild = childProfiles[0];
      } else {
        selectedChild = null; // No children left, clear selection
      }
    });
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
                if (selectedChild != null) buildProfileCard(selectedChild!),
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

  Widget buildProfileCard(ChildProfile profile) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.w,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(profile.imagePath),
            ),
            SizedBox(height: 10.h),
            Text(
              profile.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the functionality to delete a profile here
                deleteChildProfile(childProfiles.indexOf(profile));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
