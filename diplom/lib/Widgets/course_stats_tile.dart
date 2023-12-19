import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
    GetIt.I.get<Talker>().debug(dat.lessonTypes);

    return Container(
      height: 132,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                  .toList())),
    );
  }
}

class StatTile extends StatelessWidget {
  final LessonType lessonType;
  final int count;
  final int completed;
  const StatTile({
    super.key,
    required LessonType this.lessonType,
    required this.completed,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Center(
                  child: Icon(
                    lessonType.getLessonTypeIcon(),
                    size: 32,
                    color: Color.fromARGB(255, 52, 152, 219),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  value: completed / count,
                  color: Color.fromARGB(255, 52, 152, 219),
                  backgroundColor: Colors.black.withOpacity(0.3),
                ),
              ),
            ]),
            FittedBox(
              child: Text(
                lessonType.name,
                style: TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
              ),
            ),
            Text(
              "${completed}/${count}",
              style: TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
