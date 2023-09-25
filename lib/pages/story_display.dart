// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_tts/flutter_tts.dart';

// import 'package:roudy_story_app/pages/dashboard_page.dart';

// void main() {
//   runApp(MaterialApp(
//     home: StoryDisplayPage(),
//   ));
// }

// class StoryDisplayPage extends StatefulWidget {
//   @override
//   _StoryDisplayPageState createState() => _StoryDisplayPageState();
// }

// final FlutterTts flutterTts = FlutterTts(); // Initialize Flutter TTS

// class _StoryDisplayPageState extends State<StoryDisplayPage> {
//   final String textApiUrl =
//       'https://api.monsterapi.ai/v1/generate/falcon-7b-instruct';
//   final String imageApiUrl = 'https://api.monsterapi.ai/v1/generate/sdxl-base';
//   final String apiKey =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjYxNDA0ZGE0MmZhOTAwYzc5YTIwMDIyNjkyZWM1NmUwIiwiY3JlYXRlZF9hdCI6IjIwMjMtMDktMDdUMDY6MTQ6MTAuOTIzMDM2In0.Cy8tjC85ggW0BiLOpsgqfVKePGroaYqYUSKpYs1bf6w'; // Replace with your actual API key
//   TextEditingController textController = TextEditingController(
//     text: 'Write a story in 100 words of', // Initial text
//   );
//   TextEditingController generatedTextController = TextEditingController();
//   double fontSize = 15.0;
//   List<String> frameUrls = [];

//   // Add a FocusNode to manage the focus of the text field
//   final FocusNode _textFocus = FocusNode();

//   bool isTTSPlaying = false; // Track TTS playback status
//   double volumeLevel = 1.0; // Initialize volume

//   Future<void> makeAnimatedTextRequest(String prompt) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(textApiUrl))
//         ..headers['Authorization'] = apiKey
//         ..fields['prompt'] = prompt;

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(await response.stream.bytesToString());

//         if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
//           var statusUrl = jsonResponse['status_url'];
//           await pollStatusAndFetchText(statusUrl);
//         } else {
//           print('API Response does not contain "status_url".');
//         }
//       } else {
//         print('API Request Failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> pollStatusAndFetchText(String statusUrl) async {
//     try {
//       while (true) {
//         var response = await http
//             .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
//         if (response.statusCode == 200) {
//           var jsonResponse = json.decode(response.body);
//           print('Status Response: $jsonResponse');
//           var status = jsonResponse['status'];

//           if (status == 'COMPLETED') {
//             // The generation process is completed, fetch the generated text if available
//             var result = jsonResponse['result'];
//             if (result != null && result.containsKey('text')) {
//               var generatedText = result['text'];
//               setState(() {
//                 generatedTextController.text = generatedText;
//                 // Calculate the font size based on image size
//                 fontSize =
//                     generatedTextController.text.length < 100 ? 15.0 : 12.0;
//               });
//             }
//             break;
//           } else if (status == 'FAILED') {
//             print('Text generation failed.');
//             break;
//           } else {
//             // The process is still in progress, wait for a while before checking again
//             await Future.delayed(Duration(seconds: 5));
//           }
//         } else {
//           print('Status Check Failed: ${response.statusCode}');
//           break;
//         }
//       }
//     } catch (e) {
//       print('Error polling status: $e');
//     }
//   }

//   Future<void> makeAnimatedImageRequest(String prompt) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(imageApiUrl))
//         ..headers['Authorization'] = apiKey
//         ..fields['prompt'] = prompt
//         ..fields['samples'] = '2' // Number of frames
//         ..fields['steps'] = '30' // Sampling steps
//         ..fields['aspect_ratio'] = 'landscape'
//         ..fields['guidance_scale'] = '12.5'
//         ..fields['style'] = 'anime';
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(await response.stream.bytesToString());

//         if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
//           var statusUrl = jsonResponse['status_url'];
//           await pollStatusAndFetchFrames(statusUrl);
//         } else {
//           print('API Response does not contain "status_url".');
//         }
//       } else {
//         print('API Request Failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> pollStatusAndFetchFrames(String statusUrl) async {
//     try {
//       while (true) {
//         var response = await http
//             .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
//         if (response.statusCode == 200) {
//           var jsonResponse = json.decode(response.body);
//           print('Status Response: $jsonResponse');
//           var status = jsonResponse['status'];

//           if (status == 'COMPLETED') {
//             var frameList = jsonResponse['result']['output'];
//             setState(() {
//               frameUrls = List<String>.from(frameList);
//             });
//             break;
//           } else if (status == 'FAILED') {
//             print('Image generation failed.');
//             break;
//           } else {
//             await Future.delayed(Duration(seconds: 5));
//           }
//         } else {
//           print('Status Check Failed: ${response.statusCode}');
//           break;
//         }
//       }
//     } catch (e) {
//       print('Error polling status: $e');
//     }
//   }

//   Future<void> speakGeneratedStory() async {
//     if (generatedTextController.text.isNotEmpty) {
//       await flutterTts.setLanguage('en-US');
//       await flutterTts.setPitch(1.0);

//       // Set the volume before speaking
//       await flutterTts.setVolume(volumeLevel);

//       // Set the TTS playback status to true when playback starts
//       setState(() {
//         isTTSPlaying = true;
//       });

//       await flutterTts.speak(generatedTextController.text);

//       // Set the TTS playback status to false when playback completes
//       setState(() {
//         isTTSPlaying = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFF1D0),
//       body: GestureDetector(
//         onTap: () {
//           if (_textFocus.hasFocus) {
//             _textFocus.unfocus();
//           }
//         },
//         child: SingleChildScrollView(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Positioned.fill(
//                 child: Image.asset(
//                   'assets/images/book.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SafeArea(
//                     // Wrap the IconButton with SafeArea
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DashboardPage(),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: TextField(
//                       controller: textController,
//                       focusNode: _textFocus,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Text For Story',
//                         border: OutlineInputBorder(),
//                       ),
//                       onTap: () {
//                         if (textController.text ==
//                             'Write a story in 100 words for the user') {
//                           textController.clear();
//                         }
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       String prompt = textController.text;
//                       if (prompt.isNotEmpty) {
//                         makeAnimatedTextRequest(prompt);
//                         makeAnimatedImageRequest(prompt);
//                       } else {
//                         print('Please Enter Story.');
//                       }
//                     },
//                     child: Text('Generate Story and Image'),
//                   ),
//                   if (generatedTextController.text.isNotEmpty)
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       color: Color(0xFFFFF1D0).withOpacity(0.1),
//                       child: Text(
//                         generatedTextController.text,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           // fontFamily: 'IndieFlower',
//                         ),
//                       ),
//                     ),
//                   if (frameUrls.isNotEmpty)
//                     Column(
//                       children: frameUrls.map((frameUrl) {
//                         return Image.network(frameUrl);
//                       }).toList(),
//                     ),
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: speakGeneratedStory,
//                         child: Text('Read Story Aloud'),
//                       ),
//                       if (isTTSPlaying) // Show a loading indicator when TTS is playing
//                         CircularProgressIndicator(),
//                     ],
//                   ),

//                   // Add a Slider for volume control
//                   Slider(
//                     value: volumeLevel,
//                     min: 0.0,
//                     max: 1.0,
//                     onChanged: (newVolume) {
//                       setState(() {
//                         volumeLevel = newVolume;
//                         flutterTts.setVolume(newVolume);
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

class StoryDisplayPage extends StatefulWidget {
  @override
  _StoryDisplayPageState createState() => _StoryDisplayPageState();
}

class _StoryDisplayPageState extends State<StoryDisplayPage> {
  final String textApiUrl =
      'https://api.monsterapi.ai/v1/generate/falcon-7b-instruct';
  final String imageApiUrl = 'https://api.monsterapi.ai/v1/generate/sdxl-base';
  final String apiKey =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjYxNDA0ZGE0MmZhOTAwYzc5YTIwMDIyNjkyZWM1NmUwIiwiY3JlYXRlZF9hdCI6IjIwMjMtMDktMDdUMDY6MTQ6MTAuOTIzMDM2In0.Cy8tjC85ggW0BiLOpsgqfVKePGroaYqYUSKpYs1bf6w'; // Replace with your actual API key
  TextEditingController textController = TextEditingController(
    text: 'Write a story in 100 words of', // Initial text
  );
  TextEditingController generatedTextController = TextEditingController();
  double fontSize = 15.0;
  List<String> frameUrls = [];

  final FocusNode _textFocus = FocusNode();

  bool isTTSPlaying = false;
  double volumeLevel = 1.0;

  // Function to split the generated text into paragraphs of 30 words each
  List<String> splitTextIntoParagraphs(String text) {
    final List<String> words = text.split(' ');
    final List<String> paragraphs = [];
    final int wordsPerParagraph = 30;

    for (int i = 0; i < words.length; i += wordsPerParagraph) {
      final int end = i + wordsPerParagraph < words.length
          ? i + wordsPerParagraph
          : words.length;
      final String paragraph = words.sublist(i, end).join(' ');
      paragraphs.add(paragraph);
    }

    return paragraphs;
  }

  Future<void> makeAnimatedTextRequest(String prompt) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(textApiUrl))
        ..headers['Authorization'] = apiKey
        ..fields['prompt'] = prompt;

      var response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());

        if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
          var statusUrl = jsonResponse['status_url'];
          await pollStatusAndFetchText(statusUrl);
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

  Future<void> pollStatusAndFetchText(String statusUrl) async {
    try {
      while (true) {
        var response = await http
            .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('Status Response: $jsonResponse');
          var status = jsonResponse['status'];

          if (status == 'COMPLETED') {
            var result = jsonResponse['result'];
            if (result != null && result.containsKey('text')) {
              var generatedText = result['text'];

              final paragraphs = splitTextIntoParagraphs(generatedText);
              final updatedText = paragraphs.join('\n\n');

              setState(() {
                generatedTextController.text = updatedText;
                fontSize = updatedText.length < 100 ? 15.0 : 12.0;
              });

              await makeAnimatedImageRequest(updatedText);
            }
            break;
          } else if (status == 'FAILED') {
            print('Text generation failed.');
            break;
          } else {
            await Future.delayed(Duration(seconds: 5));
          }
        } else {
          print('Status Check Failed: ${response.statusCode}');
          break;
        }
      }
    } catch (e) {
      print('Error polling status: $e');
    }
  }

  Future<void> makeAnimatedImageRequest(String prompt) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(imageApiUrl))
        ..headers['Authorization'] = apiKey
        ..fields['prompt'] = prompt
        ..fields['samples'] = '4'
        ..fields['steps'] = '30'
        ..fields['aspect_ratio'] = 'landscape'
        ..fields['guidance_scale'] = '12.5'
        ..fields['style'] = 'anime';
      var response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());

        if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
          var statusUrl = jsonResponse['status_url'];
          await pollStatusAndFetchFrames(statusUrl);
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

  Future<void> pollStatusAndFetchFrames(String statusUrl) async {
    try {
      while (true) {
        var response = await http
            .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('Status Response: $jsonResponse');
          var status = jsonResponse['status'];

          if (status == 'COMPLETED') {
            var frameList = jsonResponse['result']['output'];
            setState(() {
              frameUrls = List<String>.from(frameList);
            });
            break;
          } else if (status == 'FAILED') {
            print('Image generation failed.');
            break;
          } else {
            await Future.delayed(Duration(seconds: 5));
          }
        } else {
          print('Status Check Failed: ${response.statusCode}');
          break;
        }
      }
    } catch (e) {
      print('Error polling status: $e');
    }
  }

  // Future<void> speakGeneratedStory() async {
  //   if (generatedTextController.text.isNotEmpty) {
  //     await flutterTts.setLanguage('en-US');
  //     await flutterTts.setPitch(1.0);
  //     await flutterTts.setVolume(volumeLevel);
  //     setState(() {
  //       isTTSPlaying = true;
  //     });

  //     await flutterTts.speak(generatedTextController.text);

  //     setState(() {
  //       isTTSPlaying = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF1D0),
      body: GestureDetector(
        onTap: () {
          if (_textFocus.hasFocus) {
            _textFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/book.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextField(
                    controller: textController,
                    focusNode: _textFocus,
                    decoration: InputDecoration(
                      labelText: 'Enter Text For Story',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      if (textController.text ==
                          'Write a story in 100 words for the user') {
                        textController.clear();
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String prompt = textController.text;
                    if (prompt.isNotEmpty) {
                      makeAnimatedTextRequest(prompt);
                    } else {
                      print('Please Enter Story.');
                    }
                  },
                  child: Text('Generate Story and Image'),
                ),
                if (generatedTextController.text.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Color(0xFFFFF1D0).withOpacity(0.5),
                    child: Text(
                      generatedTextController.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                if (frameUrls.isNotEmpty)
                  Column(
                    children: frameUrls.map((frameUrl) {
                      return Image.network(frameUrl);
                    }).toList(),
                  ),
                //   Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       ElevatedButton(
                //         onPressed: speakGeneratedStory,
                //         child: Text('Read Story Aloud'),
                //       ),
                //       if (isTTSPlaying) CircularProgressIndicator(),
                //     ],
                //   ),
                //   Slider(
                //     value: volumeLevel,
                //     min: 0.0,
                //     max: 1.0,
                //     onChanged: (newVolume) {
                //       setState(() {
                //         volumeLevel = newVolume;
                //         flutterTts.setVolume(newVolume);
                //       });
                //     },
                //   ),
                // ],
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class StoryDisplayPage extends StatefulWidget {
//   @override
//   _StoryDisplayPageState createState() => _StoryDisplayPageState();
// }

// class _StoryDisplayPageState extends State<StoryDisplayPage> {
//   final String textApiUrl =
//       'https://api.monsterapi.ai/v1/generate/falcon-7b-instruct';
//   final String imageApiUrl = 'https://api.monsterapi.ai/v1/generate/sdxl-base';
//   final String apiKey =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjYxNDA0ZGE0MmZhOTAwYzc5YTIwMDIyNjkyZWM1NmUwIiwiY3JlYXRlZF9hdCI6IjIwMjMtMDktMDdUMDY6MTQ6MTAuOTIzMDM2In0.Cy8tjC85ggW0BiLOpsgqfVKePGroaYqYUSKpYs1bf6w'; // Replace with your actual API key
//   TextEditingController textController = TextEditingController(
//     text: 'Write a story in 100 words of', // Initial text
//   );
//   TextEditingController generatedTextController = TextEditingController();
//   double fontSize = 20.0;
//   List<String> frameUrls = [];
//   List<String> generatedImages = []; // List to store generated images

//   final FocusNode _textFocus = FocusNode();

//   bool isTTSPlaying = false;
//   double volumeLevel = 1.0;

//   // Function to split the generated text into paragraphs of 30 words each
//   List<String> splitTextIntoParagraphs(String text) {
//     final List<String> words = text.split(' ');
//     final List<String> paragraphs = [];
//     final int wordsPerParagraph = 30;

//     for (int i = 0; i < words.length; i += wordsPerParagraph) {
//       final int end = i + wordsPerParagraph < words.length
//           ? i + wordsPerParagraph
//           : words.length;
//       final String paragraph = words.sublist(i, end).join(' ');
//       paragraphs.add(paragraph);
//     }

//     return paragraphs;
//   }

//   Future<void> makeAnimatedTextRequest(String prompt) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(textApiUrl))
//         ..headers['Authorization'] = apiKey
//         ..fields['prompt'] = prompt;

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(await response.stream.bytesToString());

//         if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
//           var statusUrl = jsonResponse['status_url'];
//           await pollStatusAndFetchText(statusUrl);
//         } else {
//           print('API Response does not contain "status_url".');
//         }
//       } else {
//         print('API Request Failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> pollStatusAndFetchText(String statusUrl) async {
//     try {
//       while (true) {
//         var response = await http
//             .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
//         if (response.statusCode == 200) {
//           var jsonResponse = json.decode(response.body);
//           print('Status Response: $jsonResponse');
//           var status = jsonResponse['status'];

//           if (status == 'COMPLETED') {
//             var result = jsonResponse['result'];
//             if (result != null && result.containsKey('text')) {
//               var generatedText = result['text'];

//               final paragraphs = splitTextIntoParagraphs(generatedText);
//               final updatedText = paragraphs.join('\n\n');

//               setState(() {
//                 generatedTextController.text = updatedText;
//                 fontSize = updatedText.length < 100 ? 15.0 : 12.0;
//               });

//               // Generate images after every paragraph
//               generatedImages.clear(); // Clear the previous images
//               for (final paragraph in paragraphs) {
//                 await makeAnimatedImageRequest(paragraph);
//               }
//             }
//             break;
//           } else if (status == 'FAILED') {
//             print('Text generation failed.');
//             break;
//           } else {
//             await Future.delayed(Duration(seconds: 5));
//           }
//         } else {
//           print('Status Check Failed: ${response.statusCode}');
//           break;
//         }
//       }
//     } catch (e) {
//       print('Error polling status: $e');
//     }
//   }

//   Future<void> makeAnimatedImageRequest(String prompt) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(imageApiUrl))
//         ..headers['Authorization'] = apiKey
//         ..fields['prompt'] = prompt
//         ..fields['samples'] = '1' // Generate 1 image
//         ..fields['steps'] = '30'
//         ..fields['aspect_ratio'] = 'landscape'
//         ..fields['guidance_scale'] = '12.5'
//         ..fields['style'] = 'anime';
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(await response.stream.bytesToString());

//         if (jsonResponse != null && jsonResponse.containsKey('status_url')) {
//           var statusUrl = jsonResponse['status_url'];
//           await pollStatusAndFetchFrames(statusUrl);
//         } else {
//           print('API Response does not contain "status_url".');
//         }
//       } else {
//         print('API Request Failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> pollStatusAndFetchFrames(String statusUrl) async {
//     try {
//       while (true) {
//         var response = await http
//             .get(Uri.parse(statusUrl), headers: {'Authorization': apiKey});
//         if (response.statusCode == 200) {
//           var jsonResponse = json.decode(response.body);
//           print('Status Response: $jsonResponse');
//           var status = jsonResponse['status'];

//           if (status == 'COMPLETED') {
//             var frameList = jsonResponse['result']['output'];
//             setState(() {
//               frameUrls = List<String>.from(frameList);
//             });
//             // Add the generated frame URL to the list
//             generatedImages.add(frameUrls.first);

//             // Check if there are more paragraphs
//             if (generatedImages.length < frameUrls.length) {
//               // Generate an image for the next paragraph
//               await makeAnimatedImageRequest('');
//             }
//             break;
//           } else if (status == 'FAILED') {
//             print('Image generation failed.');
//             break;
//           } else {
//             await Future.delayed(Duration(seconds: 5));
//           }
//         } else {
//           print('Status Check Failed: ${response.statusCode}');
//           break;
//         }
//       }
//     } catch (e) {
//       print('Error polling status: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFF1D0),
//       body: GestureDetector(
//         onTap: () {
//           if (_textFocus.hasFocus) {
//             _textFocus.unfocus();
//           }
//         },
//         child: SingleChildScrollView(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Positioned.fill(
//                 child: Image.asset(
//                   'assets/images/book.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SafeArea(
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: TextField(
//                       controller: textController,
//                       focusNode: _textFocus,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Text For Story',
//                         border: OutlineInputBorder(),
//                       ),
//                       onTap: () {
//                         if (textController.text ==
//                             'Write a story in 100 words for the user') {
//                           textController.clear();
//                         }
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       String prompt = textController.text;
//                       if (prompt.isNotEmpty) {
//                         makeAnimatedTextRequest(prompt);
//                       } else {
//                         print('Please Enter Story.');
//                       }
//                     },
//                     child: Text('Generate Story and Images'),
//                   ),
//                   if (generatedTextController.text.isNotEmpty)
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       color: Color(0xFFFFF1D0).withOpacity(0.1),
//                       child: Text(
//                         generatedTextController.text,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: fontSize,
//                         ),
//                       ),
//                     ),
//                   if (generatedImages.isNotEmpty)
//                     Column(
//                       children: generatedImages.map((frameUrl) {
//                         return Image.network(frameUrl);
//                       }).toList(),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
