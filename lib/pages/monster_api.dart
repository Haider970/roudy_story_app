import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MonsterApiDemo(),
  ));
}

class MonsterApiDemo extends StatefulWidget {
  @override
  _MonsterApiDemoState createState() => _MonsterApiDemoState();
}

class _MonsterApiDemoState extends State<MonsterApiDemo> {
  final String imageApiUrl = 'https://api.monsterapi.ai/v1/generate/sdxl-base';
  final String textApiUrl =
      'https://api.monsterapi.ai/v1/generate/falcon-7b-instruct'; // Replace with your actual text generation API URL
  final String apiKey =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjYxNDA0ZGE0MmZhOTAwYzc5YTIwMDIyNjkyZWM1NmUwIiwiY3JlYXRlZF9hdCI6IjIwMjMtMDktMDdUMDY6MTQ6MTAuOTIzMDM2In0.Cy8tjC85ggW0BiLOpsgqfVKePGroaYqYUSKpYs1bf6w'; // Replace with your actual API key from MonsterAPI
  List<String> frameUrls = [];
  List<String> storySegments = [];
  TextEditingController textController = TextEditingController();

  Future<void> generateStoryAndImages(String prompt) async {
    try {
      frameUrls.clear();
      storySegments.clear();

      var words = prompt.split(' ');
      for (var i = 0; i < words.length; i += 30) {
        var segment = words.skip(i).take(30).join(' ');
        storySegments.add(segment);

        // Generate image for the segment
        await generateImageForSegment(segment);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> generateImageForSegment(String segment) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(imageApiUrl))
        ..headers['Authorization'] = apiKey
        ..fields['prompt'] = segment
        ..fields['samples'] = '1' // Number of frames
        ..fields['steps'] = '30' // Sampling steps
        ..fields['aspect_ratio'] = 'landscape'
        ..fields['guidance_scale'] = '12.5'
        ..fields['style'] = 'anime'; // Set your desired style here

      var response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());

        if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
          var statusUrl = jsonResponse['status_url'];
          await pollImageStatusAndFetchData(statusUrl);
        } else {
          print('API Response does not contain "status_url".');
        }
      } else {
        print('API Request Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pollImageStatusAndFetchData(String statusUrl) async {
    try {
      while (true) {
        var response = await http
            .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('Image Status Response: $jsonResponse');
          var status = jsonResponse['status'];

          if (status == 'COMPLETED') {
            var result = jsonResponse['result'];
            if (result != null && result.containsKey('output')) {
              var frameList = result['output'];
              setState(() {
                frameUrls.add(frameList[0]);
              });
            }
            break;
          } else if (status == 'FAILED') {
            print('Image generation failed.');
            break;
          } else {
            await Future.delayed(Duration(seconds: 5));
          }
        } else {
          print('Image Status Check Failed: ${response.statusCode}');
          break;
        }
      }
    } catch (e) {
      print('Error polling image status: $e');
    }
  }

  Future<String> generateText(String prompt) async {
    try {
      var requestBody = json.encode({
        'text': prompt,
        'config': {
          'model': 'text-davinci-003', // Set the desired model here
          'temperature': 0.5, // Adjust temperature as needed
          'max_tokens': 50, // Adjust max tokens as needed
        },
      });

      var response = await http.post(
        Uri.parse(textApiUrl),
        headers: {
          'Authorization': apiKey,
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print('Text Generation Response: $jsonResponse'); // Debugging
        if (jsonResponse != null && jsonResponse.containsKey('choices')) {
          var text = jsonResponse['choices'][0]['text'];
          return text;
        }
      } else {
        print('Text Generation Request Failed: ${response.statusCode}');
        print(response.body); // Debugging
      }

      return 'Text generation failed.';
    } catch (e) {
      print('Error: $e');
      return 'Text generation failed.';
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monster API Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Enter Text for Image',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String prompt = textController.text;
                if (prompt.isNotEmpty) {
                  // Generate text
                  String generatedText = await generateText(prompt);
                  if (generatedText != null) {
                    // Display the generated text
                    print('Generated Text: $generatedText');
                  }
                  // Generate story and images
                  generateStoryAndImages(prompt);
                } else {
                  print('Please enter some text.');
                }
              },
              child: Text('Generate Story and Images'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: frameUrls.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.network(frameUrls[index]),
                      SizedBox(height: 20),
                      Text(storySegments[index]),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
