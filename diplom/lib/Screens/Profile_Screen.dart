// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _FIOController;
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _FIOController =
        new TextEditingController(text: "Шарипова Диана Айдаровна");
    _emailController = new TextEditingController(text: "Diana@yandex.ru");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app_outlined),
          color: const Color.fromARGB(255, 52, 152, 219),
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100,
                foregroundImage: AssetImage('assets/Avatar.png'),
                // foregroundImage: NetworkImage(
                //     "https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/d5dbb074-9311-4aa8-a9e9-595a15ab335c/600x900"),
              ),
              Container(
                height: 50,
                child: const Center(
                  child: Text("Шарипова Диана",
                      style: TextStyle(
                          color: Color.fromARGB(255, 52, 152, 219),
                          fontSize: 35,
                          fontFamily: 'Comic Sans',
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(fontFamily: 'Comic Sans'),
                      controller: _FIOController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person_2_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2)),
                          label: Text(
                            "ФИО",
                            style: TextStyle(fontFamily: 'Comic Sans'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _emailController,
                      style: TextStyle(fontFamily: 'Comic Sans'),
                      decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2)),
                          label: Text(
                            "Электронная почта",
                            style: TextStyle(fontFamily: 'Comic Sans'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          enabled: false,
                          icon: Icon(Icons.calendar_month_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2)),
                          label: Text(
                            //"Дата регистрации",
                            "11.11.2023",
                            style: TextStyle(fontFamily: 'Comic Sans'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          enabled: false,
                          icon: Icon(Icons.privacy_tip_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2)),
                          label: Text(
                            //"Роль",
                            "Пользователь",
                            style: TextStyle(fontFamily: 'Comic Sans'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 52, 152, 219),
                                  width: 2))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
