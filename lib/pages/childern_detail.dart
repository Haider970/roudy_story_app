import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screen_util

void main() {
  runApp(MaterialApp(home: ChildDetailsPage()));
}

class ChildDetailsPage extends StatefulWidget {
  @override
  _ChildDetailsPageState createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  File? _pickedImage;
  String selectedAge = '';
  String selectedGender = '';
  TextEditingController childNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    retrieveChildName();
  }

  Future<void> retrieveChildName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? childName = prefs.getString('child_name');

    if (childName != null) {
      setState(() {
        childNameController.text = childName;
      });
    }
  }

  void _handleImageUpload() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
        saveImageToPreferences(_pickedImage!.path); // Save the image path
      });
    }
  }

  Future<void> saveImageToPreferences(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('child_image', imagePath);
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
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF00F7DB), Colors.transparent],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 140.h,
                      width: 140.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF00F7DB), Colors.transparent],
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80.h,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage!)
                                : AssetImage('assets/images/child.png')
                                    as ImageProvider,
                          ),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: _handleImageUpload,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Child Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: childNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.baby_changing_station_rounded,
                        color: Colors.black,
                      ),
                      hintText: 'Enter Child Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.w),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  DropdownButtonFormField<String>(
                    value: selectedAge.isNotEmpty ? selectedAge : null,
                    onChanged: (newValue) {
                      setState(() {
                        selectedAge = newValue!;
                      });
                    },
                    items: List.generate(12, (index) {
                      return DropdownMenuItem<String>(
                        value: (index + 1).toString(),
                        child: Text((index + 1).toString()),
                      );
                    }),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.cake,
                        color: Colors.black,
                      ),
                      hintText: ('Select Age'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.w),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  DropdownButtonFormField<String>(
                    value: selectedGender.isNotEmpty ? selectedGender : null,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    items: ['Boy', 'Girl'].map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      hintText: ('Select Gender'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.w),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () async {
                      String childName = childNameController.text;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('child_name', childName);
                      print('Child Name saved: $childName'); // Add this line
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
