
import 'package:flutter/material.dart';
import 'package:flutter_calculator/Screens/registration.dart';
import 'package:flutter_calculator/repo/widgets/elevetedBtn.dart';

class OnBoardWindow extends StatelessWidget {
  const OnBoardWindow({super.key});

  @override
  Widget build(BuildContext context) {
    //String imagePath = 'assets/img/Logo.png';
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/bg.png'),
            fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height:400,
                  alignment: Alignment.center,
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 65,
                        child: Image(
                          image: AssetImage('assets/img/Logo.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'ПРИВЕТ', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontFamily: 'Alegreya'
                    ),
                  ),
                const Text(
                  'Наслаждайся отборочными. \n Будь внимателен. \n Делай хорошо.',
                   style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'AlegreyaSans'
                    ),
                   textAlign: TextAlign.center,
                   ),
                const SizedBox(height: 20,),
                elevatedBtn(
                  onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationWindow())); }, 
                  tittle: 'Войти в аккаунт',
                ),
                const SizedBox(height: 20,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text(
                      'Еще нет аккаунта?',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Alegreya'),
                      ),
                      SizedBox(width: 20,),
                      Text(
                      'Зарегистрируйтесь',
                      style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'AlegreyaSans', fontWeight: FontWeight.w500),
                      )
                  ],
                )
              ],
            ),
          )
        ),
      ),  
    );
  }
}