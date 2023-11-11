import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_testwebapioutput/api/api.dart';
import 'package:flutter_application_testwebapioutput/main.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/HomePage.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:flutter_application_testwebapioutput/repository/widgets/TextField.dart';
import 'package:get_it/get_it.dart';

class AuthrorizationScreen extends StatefulWidget {
  const AuthrorizationScreen({super.key});

  @override
  State<AuthrorizationScreen> createState() => _AuthrorizationScreenState();
}

class _AuthrorizationScreenState extends State<AuthrorizationScreen> {

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void auth(){
    if(_loginController.text == "a" && _passwordController.text == "a"){
      Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage() )));
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong"),));
  }

  @override
  void initState(){
    super.initState();
    checkserver();
  }

  void checkserver() async {
    print("Loading");
    bool succesfull = await Api().ping();
    if(succesfull){
      Data dataInstance = GetIt.I.get<Data>();
      dataInstance.itemList = await Api().getItems();
      dataInstance.itemCategory = await Api().loadCategories();
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
                  const Text("FoodPie", style: TextStyle(color: Colors.white, fontSize: 52,),textAlign: TextAlign.center,),
                  const Text("Always Give Better Food Ever", style: TextStyle(color: Colors.yellow, fontSize: 14)),
                  const SizedBox(height: 30,),
                  const SizedBox(height: 30,),
                  MyTextField(icon: Icons.person_2_outlined, hinttext: "Username",controller: _loginController,),
                  const SizedBox(height: 20,),
                  MyTextField(icon: Icons.key_off_outlined, hinttext: "Password",controller: _passwordController),
                  const SizedBox(height: 20,),
                  Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(36)),
                      onTap: () => auth(),
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