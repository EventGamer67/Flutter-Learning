import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OtherUser {
  int id;
  String avatarURL;
  DateTime registerDate;
  int role;
  String name;
  OtherUser({
    required this.id,
    required this.avatarURL,
    required this.registerDate,
    required this.role,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'avatarURL': avatarURL,
      'registerDate': registerDate.millisecondsSinceEpoch,
      'RoleID': role,
      'name': name,
    };
  }

  factory OtherUser.fromMap(Map<String, dynamic> map) {
    return OtherUser(
      id: map['id'] as int,
      avatarURL: map['avatarURL'] as String,
      registerDate: DateTime.parse(map['registerDate'] as String),
      role: map['RoleID'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtherUser.fromJson(String source) => OtherUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
