import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:roudy_story_app/pages/dashboard_page.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<ChatMessage> messages = [];
  bool canSendMessage = true;

  void _addMessage(ChatMessage message) {
    setState(() {
      messages.add(message);
      canSendMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 255, 215, 217),
      appBar: AppBar(
        title: Text('Chatbot'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(),
              ),
            );
            // Implement your back button logic
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
              onChanged: (text) {
                setState(() {
                  canSendMessage = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                if (canSendMessage) {
                  _addMessage(ChatMessage(text: text, isUser: true));
                  // Here you would call your chatbot service and handle the response
                  // For now, let's just simulate a bot reply after a delay.
                  Future.delayed(Duration(seconds: 1), () {
                    _addMessage(
                        ChatMessage(text: 'I am a Roudy', isUser: false));
                  });
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: canSendMessage
                ? () {
                    // Implement your send message logic
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBubble(
        clipper: ChatBubbleClipper5(
            type: isUser ? BubbleType.sendBubble : BubbleType.receiverBubble),
        alignment: isUser ? Alignment.topRight : Alignment.topLeft,
        backGroundColor:
            isUser ? Color.fromARGB(131, 147, 152, 66) : Colors.grey,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
