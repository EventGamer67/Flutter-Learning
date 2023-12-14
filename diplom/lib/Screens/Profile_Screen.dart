// ignore_for_file: prefer_const_constructors

import 'package:diplom/Screens/Authorization_Sreen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _FIOController;
  late TextEditingController _emailController;
  String fio = "";
  String email = "";
  String createDate = "";
  String avatarURL = "";

  @override
  void initState() {
    super.initState();
    fio = GetIt.I.get<Data>().user.name;
    email = GetIt.I.get<Data>().user.email;
    _FIOController = TextEditingController(text: fio);
    _emailController = TextEditingController(text: email);
    avatarURL = GetIt.I.get<Data>().user.avatarURL;
    final registerDatetime = GetIt.I.get<Data>().user.registerDate;
    createDate = "${registerDatetime.year}.${registerDatetime.month}.${registerDatetime.day} ${registerDatetime.hour}:${registerDatetime.minute > 9 ? registerDatetime.minute : "0${registerDatetime.minute}"}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const AuthrorizationScreen()),
            );
          },
          icon: const Icon(Icons.exit_to_app_outlined),
          color: const Color.fromARGB(255, 52, 152, 219),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              foregroundImage: NetworkImage(avatarURL),
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: FittedBox(
                  child: Text(fio,
                      style: TextStyle(
                          color: Color.fromARGB(255, 52, 152, 219),
                          fontSize: 35,
                          fontFamily: 'Comic Sans',
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 52, 152, 219),
                                width: 2)),
                        label: Text(
                          "ФИО",
                          style: TextStyle(fontFamily: 'Comic Sans'),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 52, 152, 219),
                                width: 2)),
                        label: Text(
                          "Электронная почта",
                          style: TextStyle(fontFamily: 'Comic Sans'),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 52, 152, 219),
                                width: 2)),
                        label: Text(
                          //"Дата регистрации",
                          "Дата регистрации $createDate",
                          style: TextStyle(fontFamily: 'Comic Sans'),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 52, 152, 219),
                                width: 2)),
                        label: Text(
                          //"Роль",
                          "Пользователь",
                          style: TextStyle(fontFamily: 'Comic Sans'),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 52, 152, 219),
                                width: 2))),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
