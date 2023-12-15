import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Screens/Courselearn_Screen.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  List<Course> courses = [];
  loadBloc loadbloc = loadBloc();

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  _loadCourses() async {
    try {
      courses = await Api()
          .getUserCourses(GetIt.I.get<Data>().user.id)
          .timeout(const Duration(seconds: 5));

      for (Course course in courses) {
        course.modules = await Api().loadModules(course.id);
        for (Module module in course.modules) {
          module.lessons = await Api().loadLessons(module.id);
        }
      }
      loadbloc.add(LoadLoaded());
    } catch (err) {
      loadbloc.add(LoadFailedLoading());
    }
  }

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
            BlocBuilder(
                bloc: loadbloc,
                builder: ((context, state) {
                  if (state is Loaded) {
                    return courses.length == 0  
                        ? Container(
                            height: 300,
                            child: const Center(
                              child: Text(
                                "У вас нет записей на курсы",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 52, 152, 219),
                                    fontFamily: 'Comic Sans'),
                              ),
                            ),
                          )
                        : Column(
                            children: courses
                                .map((e) => CourseTile(
                                      course: e,
                                    ))
                                .toList());
                  } else if (state is Loading) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is FailedLoading) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text("Failed Load"),
                      ),
                    );
                  }
                  return Container();
                })),
          ],
        ),
      ))),
    );
  }
}

class CourseTile extends StatefulWidget {
  final Course course;

  const CourseTile({super.key, required this.course});

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  Widget build(BuildContext context) {
    double completedPercents =
        widget.course.getLessonCompleteCount() / widget.course.getLessonCount();
    widget.course.progress = completedPercents;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CourseLearnScreen(course: widget.course);
            }));
            setState(() {});
          },
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.course.photo)),
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 52, 152, 219))),
            child: AspectRatio(
              aspectRatio: 4 / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(children: [
                  Text(widget.course.name,
                      style: const TextStyle(
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 40)
                          ],
                          fontSize: 24,
                          fontFamily: 'Comic Sans',
                          color: Colors.white)),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Прогресс: ${(completedPercents * 100).floor().toString()}%",
                      style: const TextStyle(
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 40)
                          ],
                          fontSize: 24,
                          fontFamily: 'Comic Sans',
                          color: Colors.white),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
