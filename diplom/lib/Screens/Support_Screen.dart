import 'dart:ui';

import 'package:diplom/Models/DatabaseClasses/message.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/chatBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
  List<Message> messagesNew = [];
  final TextEditingController _textController =
      TextEditingController(); // Controller for text input

  final chatBloc bloc = chatBloc();

  void loadMessages() async {
    messagesNew = await Api().loadMessages(GetIt.I.get<Data>().user!.id);
    bloc.add(ChatLoaded());
  }

  @override
  void initState() {
    loadMessages();
    super.initState();
  }

  void _handleSubmittedMessage(String text) async {
    final data = GetIt.I.get<Data>();
    try {
      final SupabaseClient sup = GetIt.I.get<Supabase>().client;
      final result = await sup.from('Messages').insert({
        'message': '$text',
        'senderID': '${data.user!.id}',
        'takerID': '${-1}',
        'created_at': '${DateTime.now()}'
      });
      GetIt.I.get<Talker>().good('send ${result}');
    } catch (err) {
      GetIt.I.get<Talker>().critical('Failed send $err');
      return;
    }

    _textController.clear();
    ChatMessage message = ChatMessage(
        message: text,
        isSentByMe: true,
        last: false,
        senderName: data.user!.name); // Creating a message

    // setState(() {
    //   messagesNew.insert(0, message); // Inserting the message  in the list
    // });
  }

  Widget _buildChatList() {
    return Flexible(
      child: ListView.builder(
        reverse: true,
        itemCount: messagesNew.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildMessage(messagesNew[index]);
        },
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      alignment: message.id == 1 ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment:
            message.id == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.id.toString(),
            style: TextStyle(fontFamily: 'Comic Sans'),
          ),
          Container(
            width: MediaQuery.of(context).size.width *
                0.7, // Примерная ширина сообщения
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                  width: 2,
                  color:
                      (message.id == 1 ? Colors.blue[100] : Colors.grey[200])!
                          .withOpacity(1)),
              color: message.id == 1 ? Colors.blue[100] : Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  message.message,
                  textAlign: message.id == 1 ? TextAlign.end : TextAlign.start,
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
    //final List<Message>? messages = await Api().loadMessages(GetIt.I.get<Data>().user!.id);

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
              BlocBuilder(
                  bloc: bloc,
                  builder: (BuildContext context, ChatStates state) {
                    if (state is Loaded) {
                      return _buildChatList();
                    } else if (state is Loading) {
                      return Flexible(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is FailedLoading) {
                      return Flexible(
                        child: Center(
                          child: Text("Failed"),
                        ),
                      );
                    }
                    return Container();
                  }),
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
