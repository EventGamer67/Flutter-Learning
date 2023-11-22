import 'package:flutter/material.dart';

class MainCoursesPage extends StatefulWidget {
  const MainCoursesPage({super.key});

  @override
  State<MainCoursesPage> createState() => _MainCoursesPageState();
}

class _MainCoursesPageState extends State<MainCoursesPage> {
  int _selectedIndex = 0;
  late final PageController _pageController;
  late final _pages;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _pages = [learnPage()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex,
          duration: Duration(seconds: 1), curve: Curves.bounceOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(40, 41, 45, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(29, 41, 57, 1.0),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, color: Colors.white),
              Text(
                "Привет, l",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(53, 59, 66, 1.0),
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.white.withOpacity(0.4),
          currentIndex: _selectedIndex,
          onTap: (value) {
            _onItemTapped(value);
          },
          items: const [
            BottomNavigationBarItem(label: "Learn", icon: Icon(Icons.school)),
            BottomNavigationBarItem(
                label: "Community", icon: Icon(Icons.group)),
            BottomNavigationBarItem(
                label: "Leaderboard", icon: Icon(Icons.leaderboard)),
            BottomNavigationBarItem(label: "Create", icon: Icon(Icons.code)),
            BottomNavigationBarItem(
              label: "Profile",
              icon: CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://sun9-37.userapi.com/impf/c845416/v845416977/26a4f/CNX79ySOb5I.jpg?size=449x600&quality=96&sign=31e9ffb131656175e52b6d448e57e401&type=album"),
                radius: 15,
              ),
            ),
          ],
        ),
        body: _pages[_selectedIndex]);
  }
}

class learnPage extends StatefulWidget {
  const learnPage({super.key});

  @override
  State<learnPage> createState() => _learnPageState();
}

class _learnPageState extends State<learnPage> {
  late final List<bool> isPanelOpen;

  @override
  void initState() {
    isPanelOpen = List.generate(20, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Divider(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      itemCount: isPanelOpen.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          shape: const Border.symmetric(vertical: BorderSide.none),
          backgroundColor: const Color.fromRGBO(40, 41, 45, 1.0),
          initiallyExpanded: isPanelOpen[index],
          onExpansionChanged: (bool expanded) {
            setState(() {
              isPanelOpen[index] = expanded;
            });
          },
          leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 35,
              )),
          title: const Text(
            "123",
            style: TextStyle(color: Colors.white),
          ),
          children: List.generate(3, (innerIndex) {
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(49, 55, 59, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListTile(
                  subtitle: Text(
                    "Lesson",
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  ),
                  title: const Text(
                    "What is C#?",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  leading: const Icon(Icons.book, color: Colors.blue),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
// SafeArea(
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: ListView.separated(
//               itemCount: 20,
//               itemBuilder: (BuildContext context, int index) {
//                 return const CourseTile();
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider();
//               },
//             )),
//       ),