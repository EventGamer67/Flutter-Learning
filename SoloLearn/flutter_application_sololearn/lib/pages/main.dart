import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_sololearn/widgets/CourseTile.dart';

class MainCoursesPage extends StatefulWidget {
  const MainCoursesPage({super.key});

  @override
  State<MainCoursesPage> createState() => _MainCoursesPageState();
}

class _MainCoursesPageState extends State<MainCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 13, 33, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 41, 57, 1.0),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu,color: Colors.white),
            Text("Привет, Ли",style: TextStyle(color: Colors.white),),
            Icon(Icons.settings,color: Colors.white,),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (BuildContext context,int index){
              return CourseTile();
            },
            separatorBuilder: (BuildContext context, int index){
              return const Divider();
            },
            )
        ),
      ),
    );
  }
}