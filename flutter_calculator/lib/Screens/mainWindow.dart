import 'package:flutter/material.dart';
import 'package:flutter_calculator/Screens/Home/account_page.dart';
import 'package:flutter_calculator/Screens/Home/main_page.dart';
import 'package:flutter_calculator/Screens/Home/music_page.dart';
import 'package:flutter_svg/svg.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});
  

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  int _selectedIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = const [
      MainPage(),
      PlaceHolderPage(
        placeholderText: "Тут будет прослушивание",
      ),
      AccountPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(37, 51, 52, 1),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromRGBO(37, 51, 52, 1),
          fixedColor: Colors.white,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,

          //
          unselectedIconTheme:
              IconThemeData(color: Colors.white.withOpacity(0.3)),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: FittedBox(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/Home.svg")),
                label: ""),
            BottomNavigationBarItem(
                icon: FittedBox(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/Nav.svg")),
                label: ""),
            BottomNavigationBarItem(
                icon: FittedBox(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/Profile.svg")),
                label: ""),
          ],
        ),
        body: pages[_selectedIndex]);
  }
}
