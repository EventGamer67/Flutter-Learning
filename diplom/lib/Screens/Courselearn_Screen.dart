// ignore_for_file: prefer_const_constructors

import 'package:diplom/Screens/LessonTest_Screen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseLearnScreen extends StatefulWidget {
  final Course course;
  const CourseLearnScreen({super.key, required this.course});

  @override
  State<CourseLearnScreen> createState() => _CourseLearnScreenState();
}

class _CourseLearnScreenState extends State<CourseLearnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.course.name,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Comic Sans',
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 40)
                          ],
                        ),
                      )),
                  background: Image.network(
                    widget.course.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          LinearProgressIndicator(
                            color: Color.fromARGB(255, 52, 152, 219),
                            backgroundColor: Color.fromARGB(60, 43, 197, 244),
                            value: 0.74,
                            minHeight: 40,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                          Center(
                            child: Text(
                              'Прогресс 74%',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Comic Sans',
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var module = widget.course.modules[index];
                    return ExpansionTile(
                      title: Text(
                        "${index + 1}. ${module.moduleName}",
                        style:
                            TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
                      ),
                      children: module.lessons.map((lesson) {
                        return ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LessonTestScreen() ));
                          },
                          subtitle: Text(
                            lessonNames[lesson.type] ?? 'None',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: 'Comic Sans'),
                          ),
                          title: Text(
                            lesson.lessonName,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Comic Sans',
                                fontSize: 20),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                          leading:
                              Icon(Icons.school_outlined, color: Colors.blue),
                        );
                      }).toList(),
                    );
                  },
                  childCount: widget.course.modules.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            child: Center(
                                child: Text(
                              "Еще немного до сертификата!",
                              style: TextStyle(
                                  fontFamily: 'Comic Sans', fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(30),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Stack(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.school_outlined,
                                    size: 80,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 4 / 2.5,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 60),
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Ты отлично справляешься! \nПродолжай учиться для открытия сертификата!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Comic Sans',
                                        overflow: TextOverflow.fade),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
