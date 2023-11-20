import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/HomePage/AccountPage.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/HomePage/CartPage.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/HomePage/Main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late int _selectedPageIndex;
  late List<Widget> screens;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    screens = [
      const HomePaage(),
      HomePageCartPage(pageController: _pageController),
      const HomePageAccoundPage()
    ];
    _selectedPageIndex = 0;
  }

  @override
  void Dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          elevation: 0,
          selectedIndex: _selectedPageIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedPageIndex = value;
              _pageController.animateToPage(_selectedPageIndex,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutQuint);
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
            NavigationDestination(
                icon: Icon(Icons.person_3_outlined), label: "Account"),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          children: screens,
        ));
  }
}
