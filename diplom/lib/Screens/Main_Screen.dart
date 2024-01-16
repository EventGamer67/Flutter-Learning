// ignore_for_file: camel_case_types, file_names

import 'package:diplom/Screens/AllCourses_Screen.dart';
import 'package:diplom/Screens/MyCourses_Screen.dart';
import 'package:diplom/Screens/Profile_Screen.dart';
import 'package:diplom/Screens/Support_Screen.dart';
import 'package:flutter/material.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  int _selectedIndex = 0;
  late final PageController _pageController;
  late final _pages;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _pages = [const MyCoursesScreen(),const CoursesGallery_Screen(),const SupportSreen(),const ProfileScreen()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
       _pageController.animateToPage(_selectedIndex,
           duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 52, 152, 219),
        //   title: const Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       //Icon(Icons.menu, color: Colors.white),
        //       Text(
        //         "Привет, Юзернейм",
        //         style: TextStyle(color: Colors.white, fontFamily: 'Comic Sans'),
        //       ),
        //       // Icon(
        //       //   Icons.settings,
        //       //   color: Colors.white,
        //       // ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.black.withOpacity(0.3),
          currentIndex: _selectedIndex,
          onTap: (value) {
            _onItemTapped(value);
          },
          items: const [
            BottomNavigationBarItem(
                label: "Навыки", icon: Icon(Icons.school_outlined)),
            BottomNavigationBarItem(label: "Запись", icon: Icon(Icons.add_box_outlined)),
            BottomNavigationBarItem(
                label: "Поддержка", icon: Icon(Icons.support_agent_outlined)),
            BottomNavigationBarItem(
              label: "Профиль",
              icon: Icon(Icons.person_2_outlined)
            ),
          ],
        ),
        //_pages[_selectedIndex]
        body: PageView(controller: _pageController, children: _pages, physics: const NeverScrollableScrollPhysics(),) );
  }
}
