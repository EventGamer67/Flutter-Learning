import 'package:flutter/material.dart';
import 'package:flutter_calculator/Services/data.dart';
import 'package:flutter_calculator/models/Feeling_model.dart';
import 'package:flutter_calculator/models/Quote_model.dart';
import 'package:flutter_calculator/repo/widgets/MediaType.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {

  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final List<Feeling> feelings = GetIt.I.get<Data>().feelings;
    final List<Quote> quotes = GetIt.I.get<Data>().quotes;

    return Scaffold(
        backgroundColor: Color.fromRGBO(37, 51, 52, 1),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromRGBO(37, 51, 52, 1),
          fixedColor: Colors.white,
          currentIndex: 0,
          onTap: (value) {
            setState(() {
              print(value);
            });
          },
          unselectedIconTheme:
              IconThemeData(color: Colors.white.withOpacity(0.3)),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: FittedBox(alignment: Alignment.center, child: SvgPicture.asset("assets/svg/Home.svg")),
                label: ""),
            BottomNavigationBarItem(
                icon: FittedBox(alignment: Alignment.center,child: SvgPicture.asset("assets/svg/Nav.svg")),
                label: ""),
            BottomNavigationBarItem(
                icon: FittedBox(alignment: Alignment.center,child: SvgPicture.asset("assets/svg/Profile.svg")),
                label: ""),
          ],
        ),
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
                            title: quotes[index].title))

                    // SizedBox(height: 20,),
                    // Container(
                    //   width: double.infinity,
                    //   height: 170,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.all(Radius.circular(20))),
                    //     child: Container(
                    //       padding: EdgeInsets.all(20),
                    //       child: Stack(
                    //         children: [
                    //           Align(
                    //             alignment: Alignment.bottomLeft,
                    //             child: Row(
                    //               children: [
                    //                 OutlinedButton(
                    //                     onPressed: () {},
                    //                     child: Text("Заказать пиццу"))
                    //               ],
                    //             ),
                    //           ),
                    //           Align(
                    //             alignment: Alignment.centerRight,
                    //             child: Image(
                    //                 image: NetworkImage(
                    //                     "https://sun9-37.userapi.com/impf/c845416/v845416977/26a4f/CNX79ySOb5I.jpg?size=449x600&quality=96&sign=31e9ffb131656175e52b6d448e57e401&type=album")),
                    //           ),
                    //           Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text("Кто делает CRUD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ),
                    //                 Text("тот крут", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), )
                    //               ])
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                    )
              ],
            ),
          ),
        )));
  }
}

Widget quoteTile(
    {required String description,
    required String title,
    required String image}) {
  return Container(
    width: double.infinity,
    height: 170,
    margin: EdgeInsets.only(bottom: 20),
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                description,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ])
          ],
        ),
      ),
    ),
  );
}
