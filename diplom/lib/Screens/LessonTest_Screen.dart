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
          backgroundColor: const Color.fromARGB(255, 52, 152, 219).withOpacity(0.6),
        ),
        body: SafeArea(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Функции органов                        ",
                  style: TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      "Какая функция относится к работе почек?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Comic Sans', fontSize: 20),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: const Text(
                              "Продуцирование желчи",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: const Text(
                              "Фильтрация крови",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: const Text(
                              "Управление температурой тела",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 52, 152, 219),
                            )),
                        child: ListTile(
                          onTap: () {},
                          title: const Text(
                              "Синтез инсулина",
                              style: TextStyle(fontFamily: 'Comic Sans')),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 52, 152, 219),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: const Center(
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
