import 'package:flutter/material.dart';
import 'package:flutter_calculator/repo/widgets/MediaType.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 51, 52, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget> [
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu,color:Colors.white, size: 40,),
                  Image(
                    image: AssetImage('assets/img/Logo.png'),
                    width: 120,
                  ),
                  CircleAvatar(radius: 25,child: Image(image:AssetImage('assets/img/Logo.png') ,),)
                ],
              ),  
              const SizedBox(height: 20,),
              const Text(
                'С возвращением, Эмиль', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Alegreya',
                  fontWeight: FontWeight.w500
                  ),
              ),
              const Text(
                'Каким ты себя ощущаешь сегодня?', 
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: 22,
                  fontFamily: 'AlegreyaSans'
                  ),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, int index) {return MediaType();}
                ),
              ),
            ],
          ),
        )
        )
    );
  }
}