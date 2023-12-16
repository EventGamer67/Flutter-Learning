// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/difficultType.dart';
import 'package:diplom/Models/DatabaseClasses/user.dart';

class Data {
  List<Course> Courses = [];
  List<DifficultTypes> difficults = [];
  List<LessonType> lessonTypes = [];
  MyUser user = MyUser(
      id: 1,
      RoleID: 1,
      password: '',
      name: '',
      email: '',
      avatarURL: '',
      registerDate: DateTime.now());
}

DifficultTypes? getCourseDifficultByID(int id) {
  return GetIt.I
      .get<Data>()
      .difficults
      .where((element) => element.id == id)
      .first;
}

class LessonType {
  int id;
  String name;
  LessonType({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory LessonType.fromMap(Map<String, dynamic> map) {
    return LessonType(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonType.fromJson(String source) =>
      LessonType.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum LessonStateTypes {
  Blocked,
  Completed,
  Current,
}

class Lesson {
  int id;
  int moduleID;
  String name;
  int type;

  String media = "";
  String text = "";

  Lesson({
    required this.id,
    required this.moduleID,
    required this.name,
    required this.type,
    required this.media,
    required this.text
  });

  LessonStateTypes getLessonState(List<Lesson> courseLessons) {
    final Data data = GetIt.I.get<Data>();
    if (data.user.completedLessonsID.contains(id)) {
      return LessonStateTypes.Completed;
    } else if ((id == courseLessons.first.id) || (data.user.completedLessonsID.contains(courseLessons.where((element) => element.id == id - 1).first.id))) {
      return LessonStateTypes.Current;
    }
    return LessonStateTypes.Blocked;
  }

  String getLessonTypeName() {
    return GetIt.I
        .get<Data>()
        .lessonTypes
        .where((element) => element.id == type)
        .first
        .name;
  }

  Icon getLessonTypeIcon() {
    switch (type) {
      case (1):
        return const Icon(
          Icons.school_outlined,
          color: Color.fromARGB(255, 52, 152, 219),
        );
      case (2):
        return const Icon(Icons.mode_edit,
            color: Color.fromARGB(255, 52, 152, 219));
      case (3):
        return const Icon(Icons.slideshow,
            color: Color.fromARGB(255, 52, 152, 219));
    }
    return const Icon(Icons.abc);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'moduleID': moduleID,
      'name': name,
      'type': type,
      'text': text,
      'media': media
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] as int,
      moduleID: map['moduleID'] as int,
      name: map['name'] as String,
      type: map['type'] as int,
      media: map['media'] as String,
      text: map['text'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) =>
      Lesson.fromMap(json.decode(source) as Map<String, dynamic>);
}
