import 'dart:ui';

import 'package:flutter/material.dart';

class ChatMessage {
  ChatMessage(
      {required this.message,
      required this.isSentByMe,
      required this.last,
      required this.senderName});
  final String message;
  final bool isSentByMe;
  final bool last;
  final String senderName;
}

class SupportSreen extends StatefulWidget {
  const SupportSreen({Key? key}) : super(key: key);

  @override
  _SupportSreenState createState() => _SupportSreenState();
}

class _SupportSreenState extends State<SupportSreen> {
  final List<ChatMessage> _messages = []; // List to store messages
  final TextEditingController _textController =
      TextEditingController(); // Controller for text input

  void _handleSubmittedMessage(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
        message: text,
        isSentByMe: false,
        last: false,
        senderName: "Лиана"); // Creating a message
    setState(() {
      _messages.insert(0, message); // Inserting the message  in the list
    });
  }

  Widget _buildChatList() {
    return Flexible(
      child: ListView.builder(
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildMessage(_messages[index]);
        },
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      alignment: message.isSentByMe ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment: message.isSentByMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          message.last == true
              ? Container()
              : Text(
                  message.senderName,
                  style: TextStyle(fontFamily: 'Comic Sans'),
                ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7, // Примерная ширина сообщения
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 2, color: (message.isSentByMe ? Colors.blue[100] : Colors.grey[200])!.withOpacity(1) ),
              color: message.isSentByMe ? Colors.blue[100] : Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  message.message,
                  textAlign:
                      message.isSentByMe ? TextAlign.end : TextAlign.start,
                  style:
                      const TextStyle(fontSize: 16.0, fontFamily: 'Comic Sans'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  tileMode: TileMode.repeated,
                  colors: [
                const Color.fromARGB(255, 52, 152, 219).withOpacity(0.1),
                Colors.white,
              ])),
          child: Column(
            children: <Widget>[
              _buildChatList(),
              const Divider(
                height: 1.0,
                color: Color.fromARGB(255, 52, 152, 219),
              ),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).canvasColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmittedMessage,
                decoration: const InputDecoration.collapsed(
                    hintText: 'Отправить сообщение',
                    hintStyle: TextStyle(fontFamily: 'Comic Sans')),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmittedMessage(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}
