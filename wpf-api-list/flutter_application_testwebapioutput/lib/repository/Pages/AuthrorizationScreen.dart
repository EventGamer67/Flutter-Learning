import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/api/api.dart';
import 'package:flutter_application_testwebapioutput/main.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/HomePage.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';

class AuthrorizationScreen extends StatefulWidget {
  const AuthrorizationScreen({super.key});

  @override
  State<AuthrorizationScreen> createState() => _AuthrorizationScreenState();
}

class _AuthrorizationScreenState extends State<AuthrorizationScreen> {

  @override
  void initState(){
    super.initState();
    checkserver();
  }

  void checkserver() async {
    print("Loading");
    bool succesfull = await Api().ping();
    if(succesfull){
      getIt<Data>().itemList = await Api().getItems();
      getIt<Data>().itemCategory = await Api().loadCategories();
      print("got");
    }
    else{
      print("worng");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 138, 120, 1),
      body:SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [ Color.fromRGBO(255, 62, 111, 1), Color.fromRGBO(255, 138, 120, 1) ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ПИЛЬДУС", style: TextStyle(color: Colors.white, fontSize: 52,),textAlign: TextAlign.center,),
                  const Text("Always Give Better Food Ever", style: TextStyle(color: Colors.yellow, fontSize: 14)),
                  const SizedBox(height: 30,),
                  const SizedBox(height: 30,),
                  const MyTextField(icon: Icons.person_2_outlined, hinttext: "Username",),
                  const SizedBox(height: 20,),
                  const MyTextField(icon: Icons.key_off_outlined, hinttext: "Password",),
                  const SizedBox(height: 20,),
                  Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(36)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage() ) )),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text("LOGIN", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                        ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont't have an account?", style: TextStyle(color: Colors.white),),
                      SizedBox(width: 5,),
                      Text("Sign Up Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ) 
      )
    );
  }
}

class MyTextField extends StatelessWidget {

  final IconData icon;
  final String hinttext;

  const MyTextField({
    super.key,
    required this.icon,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        right: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        bottom: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        left: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        ),
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      color: Colors.white.withOpacity(0.08)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextField(
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          //eybdthcfkmyst rjvbgt
          decoration: InputDecoration.collapsed(
              hintText: hinttext,
              hintStyle: const TextStyle(color: Colors.white)
          ),),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.centerLeft,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: Center(child: Icon(icon, size: 36, color: Colors.red))
              ),
            ),
          ),
          ]
      ));
  }
}