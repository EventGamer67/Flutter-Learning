import 'dart:convert';

import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Models/DatabaseClasses/user.dart';
import 'package:diplom/Services/Data.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Course {
  int id;
  String name;
  String description;
  String photo;
  int difficultID;
  double progress = 0;
  List<Module> modules = [];
  int author;

  int getLessonCount() {
    int sum = 0;
    for (Module module in modules) {
      sum += module.lessons.length;
    }
    return sum;
  }

  int getLessonCompleteCount(){
    final MyUser user = GetIt.I.get<Data>().user;
    List<Lesson> lessons = [];
    for(Module module in modules){
      for(Lesson lesson in module.lessons){
        lessons.add(lesson);
      }
    }
    return lessons.where( (element) => user.completedLessonsID.contains(element.id)).length;
  }

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.difficultID,
    required this.author
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
      author: map['author'] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);
}
