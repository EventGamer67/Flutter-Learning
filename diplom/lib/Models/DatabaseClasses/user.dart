import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  int id;
  // ignore: non_constant_identifier_names
  int RoleID;
  String password;
  String name;
  String email;
  String avatarURL;
  DateTime registerDate;
  List<int> completedLessonsID = [];

  MyUser({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.RoleID,
    required this.password,
    required this.email,
    required this.name,
    required this.avatarURL,
    required this.registerDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'RoleID': RoleID,
      'password': password,
      'email': email,
      'name':name,
      'avatarURL': avatarURL,
      'registerDate': registerDate.millisecondsSinceEpoch,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] as int,
      name: map['name'] as String,
      RoleID: map['RoleID'] as int,
      password: map['password'] as String,
      email: map['email'] as String,
      avatarURL: map['avatarURL'] as String,
      registerDate: DateTime.parse(map['registerDate'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
 