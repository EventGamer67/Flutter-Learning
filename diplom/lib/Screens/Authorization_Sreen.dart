// ignore_for_file: file_names

import 'package:diplom/Screens/Main_Screen.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Widgets/IconTextField_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthrorizationScreen extends StatefulWidget {
  const AuthrorizationScreen({super.key});

  @override
  State<AuthrorizationScreen> createState() => _AuthrorizationScreenState();
}

class _AuthrorizationScreenState extends State<AuthrorizationScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool inword = false;

  @override
  void initState() {
    super.initState();
  }

  void goToMain(context) async {
    setState(() {
      inword = true;
    });
    final result = await Api().login(
        password: _passwordController.text, email: _loginController.text);
    if (result == null) {
      setState(() {
        inword = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text(
                "Ошибка",
                style: TextStyle(fontFamily: 'Comic Sans'),
              ),
              actions: [
                CupertinoButton(
                    child: const Text("Закрыть",
                        style: TextStyle(fontFamily: 'Comic Sans')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
      return;
    }

    final Data data = GetIt.I.get<Data>();
    data.user = result;
    if (data.user.RoleID == 2) {
      setState(() {
        inword = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text(
                "Вы не можете зайти как администратор",
                style: TextStyle(fontFamily: 'Comic Sans'),
              ),
              actions: [
                CupertinoButton(
                    child: const Text("Закрыть",
                        style: TextStyle(fontFamily: 'Comic Sans')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
      return;
    }
    await Api().loadData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const Main_Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: const BoxDecoration(
          //color: Colors.white
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                child: Text(
                  "Самообразование",
                  style: TextStyle(
                      color: Color.fromARGB(255, 52, 152, 219),
                      fontSize: 43,
                      fontFamily: 'Comic Sans'),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text("Развитие навыки вместе с нами!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 52, 152, 219),
                      fontFamily: 'Comic Sans',
                      fontSize: 14)),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                
                  icon: Icons.email_outlined,
                  hinttext: "Электронная почта",
                  controller: _loginController,
                  showpassword: false),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  icon: Icons.key_outlined,
                  hinttext: "Пароль",
                  controller: _passwordController,
                  showpassword: true),
              const SizedBox(
                height: 20,
              ),
              Material(
                color: inword
                    ? const Color.fromARGB(255, 141, 141, 141)
                    : const Color.fromARGB(255, 52, 152, 219),
                borderRadius: const BorderRadius.all(Radius.circular(36)),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                  onTap: () {
                    if (!inword) {
                      goToMain(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Вход",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Comic Sans'),
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Забыли пароль?",
              //       style: TextStyle(
              //           color: Color.fromARGB(255, 52, 152, 219),
              //           fontFamily: 'Comic Sans'),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       "Восставновить",
              //       style: TextStyle(
              //           color: Color.fromARGB(255, 52, 152, 219),
              //           fontFamily: 'Comic Sans',
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    )));
  }
}
