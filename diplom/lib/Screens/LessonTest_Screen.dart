import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonTestScreen extends StatefulWidget {
  const LessonTestScreen({super.key});

  @override
  State<LessonTestScreen> createState() => _LessonTestScreenState();
}

class _LessonTestScreenState extends State<LessonTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 60,
          backgroundColor: Color.fromARGB(255, 52, 152, 219).withOpacity(0.6),
        ),
        body: SafeArea(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Вопрос 1.2",
                  style: TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "Чем профессиональная педагогическая деятельность отличается от непрофессиональной?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Comic Sans', fontSize: 20),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                              "Осуществляется в специально созданных условиях",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                              "Гарантирует высокий результат деятельности",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                              "Предполагает наличие профессионального образования у педагога",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                              "Осуществляется по специально разработанным программам",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 52, 152, 219),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Center(
                          child: Text("Далее",
                              style: TextStyle(
                                  fontFamily: 'Comic Sans',
                                  color: Colors.white, fontSize: 24)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
