import 'package:flutter/material.dart';
import 'package:roudy_story_app/pages/dashboard_page.dart';

void main() {
  runApp(MaterialApp(
    home: PricingPage(),
  ));
}

class PricingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(234, 162, 210, 255),
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: PricingPlan(
                      title: 'Free Plan',
                      price: 'Free',
                      icon: Icons.directions_bike,
                      features: [
                        '10 stories in a day',
                        '2 Image generation with stories',
                      ],
                      backgroundColor: Color(0xE0E0E0),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 300,
                    child: PricingPlan(
                      title: 'Basic Plan',
                      price: '\$14.99',
                      icon: Icons.motorcycle,
                      features: [
                        '30 stories in a day',
                        '5 Image generation with stories',
                        'Chatbot interaction',
                      ],
                      backgroundColor: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 300,
                    child: PricingPlan(
                      title: 'Premium Plan',
                      price: '\$29.99',
                      icon: Icons.directions_car,
                      features: [
                        'Unlimited stories in a day',
                        'Unlimited Image generation with stories',
                        'Chatbot interaction',
                        'Text to speech',
                      ],
                      backgroundColor: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PricingPlan extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final List<String> features;
  final Color backgroundColor;

  PricingPlan({
    required this.title,
    required this.price,
    required this.icon,
    required this.features,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            price,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map((feature) => Text(
                      '• $feature',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
