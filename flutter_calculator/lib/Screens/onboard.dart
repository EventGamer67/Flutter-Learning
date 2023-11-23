import 'package:flutter/material.dart';
import 'package:flutter_calculator/Screens/registration.dart';
import 'package:flutter_calculator/Services/api.dart';
import 'package:flutter_calculator/Services/data.dart';
import 'package:flutter_calculator/repo/widgets/elevetedBtn.dart';
import 'package:get_it/get_it.dart';

class OnBoardWindow extends StatelessWidget {
  const OnBoardWindow({super.key});

  _loadData() async{
    Data data = GetIt.I.get<Data>();
    Api api = GetIt.I.get<Api>();

    data.feelings = await api.getFeelings();
    data.quotes = await api.getQuotes();

    print("succ");
  }

  @override
  Widget build(BuildContext context) {

    _loadData();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/bg.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Stack(
          children: [
            Center(
              child: Container(
                height: 400,
                alignment: Alignment.center,
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/img/Logo.png'),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'ПРИВЕТ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Alegreya'),
                ),
                const Text(
                  'Наслаждайся отборочными. \n Будь внимателен. \n Делай хорошо.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'AlegreyaSans'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: elevatedBtn(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationWindow()));
                    },
                    tittle: 'Войти в аккаунт',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Еще нет аккаунта?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Alegreya'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Зарегистрируйтесь',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'AlegreyaSans',
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 35,
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
