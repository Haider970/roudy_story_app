import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextGenerationPage extends StatefulWidget {
  @override
  _TextGenerationPageState createState() => _TextGenerationPageState();
}

class _TextGenerationPageState extends State<TextGenerationPage> {
  final TextEditingController _inputController = TextEditingController();
  String _generatedText = '';
  String _error = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> generateText() async {
    final prompt = _inputController.text;
    final apiKey =
        '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'; // Replace with your OpenAI API key
    final url =
        Uri.parse('https://api.openai.com/v1/engines/davinci/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'prompt': prompt,
        'max_tokens': 500, // Adjust as needed
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final generatedText = data['choices'][0]['text'];
      setState(() {
        _generatedText = generatedText;
        _error = '';
      });
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['error']['message'];
      setState(() {
        _error = ' $errorMessage';
        _generatedText = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Generation App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Enter a prompt',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateText,
              child: Text('Generate Text'),
            ),
            SizedBox(height: 16),
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            Text('Generated Text:'),
            Text(_generatedText),
          ],
        ),
      ),
    );
  }
}
