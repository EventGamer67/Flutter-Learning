import 'package:diplom/Screens/Main_Screen.dart';
import 'package:diplom/Widgets/IconTextField_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthrorizationScreen extends StatefulWidget {
  const AuthrorizationScreen({super.key});

  @override
  State<AuthrorizationScreen> createState() => _AuthrorizationScreenState();
}

class _AuthrorizationScreenState extends State<AuthrorizationScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // void auth() async {
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   final response = await Api().Login(password: _loginController.text, login: _passwordController.text);
  //   if(response == true){

  //     Navigator.pop(context);
  //     Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage() )));
  //     return;
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong data"),));
  // }

  @override
  void initState() {
    super.initState();
    //checkserver();
  }

  void goToMain() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (BuildContext context) => Main_Screen()),
  );
}


  // void checkserver() async {
  //   print("Loading");
  //   bool succesfull = await Api().ping();
  //   if(succesfull){
  //     Data dataInstance = GetIt.I.get<Data>();
  //     dataInstance.itemList = await Api().getItems();
  //     dataInstance.itemCategory = await Api().loadCategories();
  //     dataInstance.user = User();
  //     print("got");
  //   }
  //   else{
  //     print("worng");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 52, 152, 219),
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
                  const Text(
                    "Цифровое искусство",
                    style: TextStyle(
                        color: Color.fromARGB(255, 52, 152, 219),
                        fontSize: 52,
                        fontFamily: 'Comic Sans'),
                    textAlign: TextAlign.center,
                  ),
                  const Text("Развитие навыков самообразования",
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
                    color: Color.fromARGB(255, 52, 152, 219),
                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(36)),
                      onTap: () => goToMain(),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Забыли пароль?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 152, 219),
                            fontFamily: 'Comic Sans'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Восставновить",
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 152, 219),
                            fontFamily: 'Comic Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
