// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
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
  bool sending = false;

  late final StreamSubscription<List<Map<String, dynamic>>> messageStream;

  loadMessages() async {
    messagesNew = await Api().loadMessages(GetIt.I.get<Data>().user.id);
    messagesNew.sort((a, b) {
      return a.id > b.id ? -1 : 1;
    });
    GetIt.I.get<Data>().users = await Api().loadUsers();
    bloc.add(ChatLoaded());

    final Supabase sup = GetIt.I.get<Supabase>();
    messageStream = sup.client
        .from("Messages")
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      Message message = Message(
          id: data.last['id'],
          message: data.last['message'],
          senderID: data.last['senderID'],
          takerID: data.last['takerID'],
          created_at: DateTime.parse(data.last['created_at']));
      setState(() {
        if (messagesNew.first.id != message.id) {
          messagesNew.insert(0, message);
        }
      });
    });
    messageStream.resume();
  }

  @override
  void initState() {
    loadMessages();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageStream.cancel();
  }

  void _handleSubmittedMessage(String text) async {
    if (!sending) {
      if (_textController.text != "") {
        final data = GetIt.I.get<Data>();
        try {
          final SupabaseClient sup = GetIt.I.get<Supabase>().client;
          setState(() {
            sending = true;
          });
          final result = await sup.from('Messages').insert({
            'message': text,
            'senderID': '${data.user.id}',
            'takerID': '${-1}',
            'created_at': '${DateTime.now()}'
          });
          _textController.clear();
          GetIt.I.get<Talker>().good('send $result');
          sending = false;
        } catch (err) {
          GetIt.I.get<Talker>().critical('Failed send $err');
          sending = false;
          return;
        }
        setState(() {});
      }
    }
  }

  Widget _buildChatList() {
    return Flexible(
      child: ListView.builder(
        reverse: true,
        itemCount: messagesNew.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildMessage(
              messagesNew[index],
              messagesNew[min(index + 1, messagesNew.length - 1)],
              messagesNew[max(index - 1, 0)]);
        },
      ),
    );
  }

  Widget _buildMessage(Message message, Message previous, Message next) {
    final int myID = GetIt.I.get<Data>().user.id;
    bool isMe = message.senderID == myID ? true : false;

    bool lastSenderIsCurrent = previous.senderID == message.senderID;
    if (previous.id == message.id) {
      lastSenderIsCurrent = false;
    }

    bool nextSenderIsCurrent = next.senderID == message.senderID;
    if (next.id == message.id) {
      nextSenderIsCurrent = false;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          lastSenderIsCurrent
              ? SizedBox()
              : Text(
                  isMe
                      ? "Вы"
                      : GetIt.I.get<Data>().getUserName(message.senderID),
                  style: const TextStyle(fontFamily: 'Comic Sans'),
                ),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isMe
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.only(right: 5),
                      child: nextSenderIsCurrent
                          ? SizedBox()
                          : CircleAvatar(
                              radius: 20,
                              foregroundImage: CachedNetworkImageProvider(
                                GetIt.I
                                    .get<Data>()
                                    .getUserById(message.senderID)
                                    .avatarURL,
                              ),
                            ),
                    ),
              LimitedBox(
                maxWidth: 0.8 * MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        width: 2,
                        color: (isMe ? Colors.blue[100] : Colors.grey[200])!
                            .withOpacity(1)),
                    color: isMe ? Colors.blue[100] : Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message.message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: const TextStyle(
                          fontSize: 16.0, fontFamily: 'Comic Sans'),
                    ),
                  ),
                ),
              ),
              !isMe
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.only(left: 5),
                      child: nextSenderIsCurrent
                          ? SizedBox()
                          : CircleAvatar(
                              radius: 20,
                              foregroundImage: CachedNetworkImageProvider(
                                GetIt.I
                                    .get<Data>()
                                    .getUserById(message.senderID)
                                    .avatarURL,
                              ),
                            ),
                    ),
            ],
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
                      return const Flexible(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is FailedLoading) {
                      return const Flexible(
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
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: TextStyle(fontFamily: 'Comic Sans'),
              controller: _textController,
              onSubmitted: _handleSubmittedMessage,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Отправить сообщение',
                  hintStyle: TextStyle(fontFamily: 'Comic Sans')),
            ),
          ),
          sending
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue.shade400,
                  ),
                  onPressed: () =>
                      _handleSubmittedMessage(_textController.text),
                ),
        ],
      ),
    );
  }
}
