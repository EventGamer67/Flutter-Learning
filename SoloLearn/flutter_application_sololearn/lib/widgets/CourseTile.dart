import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Color.fromRGBO(29, 41, 57, 1.0),
      child: ListTile(  
        title: Text("Курс 1", style: TextStyle(color: Colors.white),),
        leading: Icon(Icons.lock_rounded, color: Colors.amber,),
      ),
    );
  }
}