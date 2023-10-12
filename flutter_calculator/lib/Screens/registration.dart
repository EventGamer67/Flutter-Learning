import 'package:flutter/material.dart';
import 'package:flutter_calculator/repo/widgets/elevetedBtn.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationWindow extends StatefulWidget {
  const RegistrationWindow({super.key});

  @override
  State<RegistrationWindow> createState() => _RegistrationWindowState();
}

class _RegistrationWindowState extends State<RegistrationWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 51, 52, 1),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children:[
          Container(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage('assets/img/Logo.png'),
                            width: 120,
                            ),
                          Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Alegreya'
                            ),
                          textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: const Column(
                          children: [
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsetsDirectional.only(start: 10),
                                  hintText: " Email",
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(190, 194, 194, 1)
                                  )
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                              SizedBox(height: 30,),
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsetsDirectional.only(start: 10),
                                  hintText: " Пароль",
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(190, 194, 194, 1),
                                    fontSize: 16
                                  )
                                ),
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                          ],
                        ),
                    ),
                    const SizedBox(height: 60,),
                    elevatedBtn(tittle: "Sign in", onTap: () => {} ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'AlegreyaSans'
                              ),
                            textAlign: TextAlign.center,
                            )
                    ),
                    const SizedBox(height: 30,),
                    elevatedBtn(tittle: "Профиль", onTap: () => {} )
                  ]
              ),)
          ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset('assets/svg/leafs.svg',width: MediaQuery.of(context).size.width,),
        ),
      ]),
    );
  }
}