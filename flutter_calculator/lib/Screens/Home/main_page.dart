import 'package:flutter/material.dart';
import 'package:flutter_calculator/Services/data.dart';
import 'package:flutter_calculator/models/Feeling_model.dart';
import 'package:flutter_calculator/models/Quote_model.dart';
import 'package:flutter_calculator/repo/widgets/MediaType.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final List<Feeling> feelings;
  late final List<Quote> quotes;

  @override
  void initState() {
    super.initState();
    feelings = GetIt.I.get<Data>().feelings;
    quotes = GetIt.I.get<Data>().quotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 51, 52, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  ),
                  Image(
                    image: AssetImage('assets/img/Logo.png'),
                    width: 120,
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: Image(
                      image: AssetImage('assets/img/Logo.png'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'С возвращением, Эмиль',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Alegreya',
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                'Каким ты себя ощущаешь сегодня?',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: 22,
                    fontFamily: 'AlegreyaSans'),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: feelings.length,
                    itemBuilder: (context, int index) {
                      return MediaType(feeling: feelings[index]);
                    }),
              ),
              Column(
                  children: List.generate(
                      quotes.length,
                      (index) => quoteTile(
                          description: quotes[index].description,
                          image: quotes[index].image,
                          title: quotes[index].title)))
            ],
          ),
        ),
      )),
    );
  }
}

Widget quoteTile(
    {required String description,
    required String title,
    required String image}) {
  return Container(
    width: double.infinity,
    height: 170,
    margin: const EdgeInsets.only(bottom: 20),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  OutlinedButton(
                      onPressed: () {}, child: const Text("Заказать пиццу"))
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Image(image: NetworkImage(image)),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                            fontFamily: 'Alegreya',
                          ),
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Alegreya',
                          ),
                        )
                      ]),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
