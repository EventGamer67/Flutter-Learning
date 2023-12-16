import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DifficultTypes {
  int id;
  String name;
  DifficultTypes({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory DifficultTypes.fromMap(Map<String, dynamic> map) {
    return DifficultTypes(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DifficultTypes.fromJson(String source) =>
      DifficultTypes.fromMap(json.decode(source) as Map<String, dynamic>);
}
