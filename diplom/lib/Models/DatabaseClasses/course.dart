import 'dart:convert';

class Course {
  int id;
  String name;
  String description;
  String photo;
  int difficultID;
  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.difficultID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'photo': photo,
      'difficultID': difficultID,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      photo: map['photo'] as String,
      difficultID: map['difficultID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);
}