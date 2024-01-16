// ignore_for_file: file_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserPractice {
  int id;
  int user;
  int lesson;
  String text;
  String fileLinks;
  UserPractice({
    required this.id,
    required this.user,
    required this.lesson,
    required this.text,
    required this.fileLinks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'lesson': lesson,
      'text': text,
      'fileLinks': fileLinks,
    };
  }

  factory UserPractice.fromMap(Map<String, dynamic> map) {
    return UserPractice(
      id: map['id'] as int,
      user: map['user'] as int,
      lesson: map['lesson'] as int,
      text: map['text'] as String,
      fileLinks: map['fileLinks'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPractice.fromJson(String source) => UserPractice.fromMap(json.decode(source) as Map<String, dynamic>);
}
