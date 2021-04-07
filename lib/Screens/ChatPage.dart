import 'package:flutter/material.dart';
import 'package:at_chat_flutter/at_chat_flutter.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Chat'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: ChatScreen(
          height: MediaQuery.of(context).size.height,
          incomingMessageColor: Colors.blue[100],
          outgoingMessageColor: Colors.deepOrangeAccent[100],
          isScreen: true,
          hintText: 'What\'s on your plate?',
        ),
      ),
    );
  }
}
