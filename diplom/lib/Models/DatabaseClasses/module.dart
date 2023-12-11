import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Module {
  int id;
  int courseID;
  String name;
  Module({
    required this.id,
    required this.courseID,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseID': courseID,
      'name': name,
    };
  }

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['id'] as int,
      courseID: map['courseID'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Module.fromJson(String source) => Module.fromMap(json.decode(source) as Map<String, dynamic>);
}
