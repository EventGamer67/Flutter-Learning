import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Screens/Courselearn_Screen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const FittedBox(
                child: Text(
                  "Добро пожаловать!",
                  style: TextStyle(
                      fontFamily: 'Comic Sans',
                      fontSize: 36,
                      color: Color.fromARGB(255, 52, 152, 219)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 52, 152, 219)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Дистанционное обучение может быть эффективным инструментом для личного и профессионального развития, предоставляя учащимся возможность обучаться в комфортной обстановке и на своем собственном темпе.Краткое обучение использование приложения:При переходе в окно Мой профиль вы можете изменить информацию о себе.Окно Запись на дистанционное обучение позволит вам выбрать курс обучения и записаться на него.В окне Мои курсы вы можете просмотреть свой прогресс обучения.",
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Comic Sans'),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Мои курсы",
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 52, 152, 219),
                    fontFamily: 'Comic Sans'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CourseTile(
              imageUrl:
                  "https://images.spiceworks.com/wp-content/uploads/2023/05/17141122/Shutterstock_2079263023.jpg",
              courseName: "С# для маленьких и дебилов",
              completedPercents: "74%",
              course: Course(
                id: 1,
                name: "Введение в педагогику",
                description: "1232",
                photo: "https://www.phoenix.edu/content/dam/edu/blog/2023/02/Male-programmer-writing-code-in-modern-office-704x421.jpg",
                difficultID: 1
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CourseTile(
              imageUrl:
                  "https://images.spiceworks.com/wp-content/uploads/2023/05/17141122/Shutterstock_2079263023.jpg",
              courseName: "С# для маленьких и дебилов",
              completedPercents: "74%",
              course: Course(
                id: 2,
                name: "Педагогический дизайн урока",
                description: "1232",
                photo: "https://www.limestone.edu/sites/default/files/styles/news_preview_image/public/2022-03/computer-programmer.jpg?h=2d4b268f&itok=JOcIEe9u",
                difficultID: 1
              ),
            ),
          ],
        ),
      ))),
    );
  }
}

class CourseTile extends StatelessWidget {
  final imageUrl;
  final courseName;
  final completedPercents;
  final Course course;

  const CourseTile(
      {super.key, this.imageUrl, this.courseName, this.completedPercents, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) { return CourseLearnScreen(course: course); }));
      },
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(course.photo)),
            border: Border.all(
                width: 3, color: const Color.fromARGB(255, 52, 152, 219))),
        child: AspectRatio(
          aspectRatio: 4 / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(children: [
              Text(course.name,
                  style: const TextStyle(
                    shadows: [Shadow(color: Colors.black,blurRadius: 40)],
                      fontSize: 24,
                      fontFamily: 'Comic Sans',
                      color: Colors.white)),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  completedPercents ?? "100%",
                  style: const TextStyle(
                    shadows: [Shadow(color: Colors.black,blurRadius: 40)],
                      fontSize: 24,
                      fontFamily: 'Comic Sans',
                      color: Colors.white),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
