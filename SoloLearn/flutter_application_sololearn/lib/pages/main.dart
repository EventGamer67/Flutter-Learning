import 'package:flutter/material.dart';

class MainCoursesPage extends StatefulWidget {
  const MainCoursesPage({super.key});

  @override
  State<MainCoursesPage> createState() => _MainCoursesPageState();
}

class _MainCoursesPageState extends State<MainCoursesPage> {
  int _selectedIndex = 0;
  final List<bool> isPanelOpen = List.generate(10, (index) => false);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(5, 13, 33, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(29, 41, 57, 1.0),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, color: Colors.white),
              Text(
                "Привет, Ли",
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
        body: SingleChildScrollView(
            child: ExpansionPanelList(
              expandIconColor: Colors.red,
          dividerColor: Colors.white.withOpacity(0.2),
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              isPanelOpen[panelIndex] = !isPanelOpen[panelIndex];
              print(isPanelOpen);
            });
          },
          children: List.generate(10, (index) {
            return ExpansionPanel(
              canTapOnHeader: true,
              backgroundColor: Color.fromRGBO(40, 41, 45, 1.0),
              isExpanded: isPanelOpen[index],
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Header ${index + 1}",style: TextStyle(color: Colors.white),),
                );
              },
              body: ListTile(
                leading: Icon(Icons.abc),
                title: Text("Expanded ${index + 1}"),
                subtitle:
                    const Text('To delete this panel, tap the trash can icon'),
                trailing: const Icon(Icons.delete),
                onTap: () {},
              ),
            );
          }),
        )));
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