  // ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Screens/Course_Sreen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CoursesGallery_Screen extends StatefulWidget {
  const CoursesGallery_Screen({super.key});

  @override
  State<CoursesGallery_Screen> createState() => _CoursesGallery_ScreenState();
}

class _CoursesGallery_ScreenState extends State<CoursesGallery_Screen> {
  late List<Course> coursesList;

  @override
  void initState() {
    super.initState();
    final Data dat = GetIt.I.get<Data>();
    coursesList = dat.Courses.toList().where((e) => !dat.ClosedCourses.contains(e.id)).toList()..sort((a, b) {
      return a.name.compareTo(b.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Все курсы",
              style: TextStyle(
                  fontFamily: 'Comic Sans',
                  fontSize: 30,
                  color: Color.fromARGB(255, 52, 152, 219)),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: coursesList.length,
                itemBuilder: ((context, index) {
                  return AllCoursesTile(
                    courseName: coursesList[index].name,
                    difficult:
                        "Уровень: ${getCourseDifficultByID(coursesList[index].difficultID)!.name.toString()}",
                    imageURL: coursesList[index].photo,
                    course: coursesList[index],
                  );
                })),
          ]),
        ),
      )),
    );
  }
}

class AllCoursesTile extends StatelessWidget {
  final String courseName;
  final String difficult;
  final String imageURL;
  final Course course;

  const AllCoursesTile(
      {super.key,
      required this.courseName,
      required this.imageURL,
      required this.course,
      required this.difficult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return CourseScreen(
              course: course,
            );
          }),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imageURL))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                    aspectRatio: 4 / 2.5,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            courseName,
                            style: TextStyle(
                                shadows: const [
                                  Shadow(color: Colors.black, blurRadius: 40)
                                ],
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Comic Sans'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            difficult,
                            style: TextStyle(
                                shadows: const [
                                  Shadow(color: Colors.black, blurRadius: 40)
                                ],
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Comic Sans'),
                          ),
                        ),
                      ],
                    )),
              )),
        ]),
      ),
    );
  }
}
