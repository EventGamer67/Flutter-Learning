import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Practise {
  int id;
  int lesson;
  bool active;
  Map<String,dynamic> flags;
  Practise({
    required this.id,
    required this.lesson,
    required this.active,
    required this.flags,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lesson': lesson,
      'active': active,
      'flags': flags,
    };
  }

  factory Practise.fromMap(Map<String, dynamic> map) {
    return Practise(
      id: map['id'] as int,
      lesson: map['lesson'] as int,
      active: map['active'] as bool,
      flags: map['flags'] as Map<String,dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory Practise.fromJson(String source) => Practise.fromMap(json.decode(source) as Map<String, dynamic>);
}
