import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CourseStateTile extends StatelessWidget {
  final Course course;
  final List<Lesson> lessons;
  const CourseStateTile(
      {super.key, required this.course, required this.lessons});

  @override
  Widget build(BuildContext context) {
    final dat = GetIt.I.get<Data>();
    final lessontypes = dat.lessonTypes.where((element) =>
        lessons.map((e) => e.type).toSet().toList().contains(element.id));

    return IntrinsicHeight(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: lessontypes
                    .map((e) => StatTile(
                          lessonType: e,
                          count: lessons
                              .where((element) => element.type == e.id)
                              .length,
                          completed: lessons
                              .where((element) =>
                                  element.type == e.id &&
                                  dat.user.completedLessonsID
                                      .contains(element.id))
                              .length,
                        ))
                    .toList()),
          )),
    );
  }
}

class StatTile extends StatelessWidget {
  final LessonType lessonType;
  final int count;
  final int completed;
  const StatTile({
    super.key,
    required this.lessonType,
    required this.completed,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Stack(children: [
              FittedBox(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: Icon(
                      lessonType.getLessonTypeIcon(),
                      size: 32,
                      color: const Color.fromARGB(255, 52, 152, 219),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  value: completed / count,
                  color: const Color.fromARGB(255, 52, 152, 219),
                  backgroundColor: Colors.black.withOpacity(0.3),
                ),
              ),
            ]),
          ),
          Text(
            lessonType.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
          ),
          Text(
            "$completed/$count",
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
          )
        ],
      ),
    );
  }
}
