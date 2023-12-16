import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  int id;
  String message;
  int senderID;
  int takerID;
  DateTime created_at;
  Message({
    required this.id,
    required this.message,
    required this.senderID,
    required this.takerID,
    required this.created_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'senderID': senderID,
      'takerID': takerID,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      message: map['message'] as String,
      senderID: map['senderID'] as int,
      takerID: map['takerID'] as int,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
