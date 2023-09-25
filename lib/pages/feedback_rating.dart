import 'package:flutter/material.dart';
import 'package:roudy_story_app/pages/dashboard_page.dart';

class FeedbackRatingPage extends StatefulWidget {
  @override
  _FeedbackRatingPageState createState() => _FeedbackRatingPageState();
}

class _FeedbackRatingPageState extends State<FeedbackRatingPage> {
  double _rating = 0;
  String _feedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 215, 252),
        title: Text('Feedback & Rating'),
      ),
      backgroundColor: Color.fromARGB(255, 255, 215, 217),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'How would you rate our app?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = i.toDouble();
                      });
                    },
                    child: Icon(
                      i <= _rating ? Icons.star : Icons.star_border,
                      size: 40,
                      color: Colors.amber,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Tell us your feedback:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 3,
                maxLength: 255, // Character limit
                onChanged: (value) {
                  setState(() {
                    _feedback = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your feedback here...',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle feedback submission here
                print('Rating: $_rating');
                print('Feedback: $_feedback');

                if (_rating == 5) {
                  // Show a snackbar with a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your response has been submitted!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  // If rating is not 5, navigate to the dashboard
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                }

                // You can send the data to your server or perform other actions.
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    234, 227, 215, 252), // Button background color
              ),
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FeedbackRatingPage(),
  ));
}
