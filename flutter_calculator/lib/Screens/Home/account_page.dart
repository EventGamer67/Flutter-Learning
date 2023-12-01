import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _PlaceHolderPageState();
}

class _PlaceHolderPageState extends State<AccountPage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 51, 52, 1),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
                  IconButton(
                      onPressed: null,
                      icon: Text("Exit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Alegreya',
                              fontWeight: FontWeight.w500))),
                ],
              ),
              CircleAvatar(
                radius: 75,
                foregroundImage:
                    NetworkImage("https://i.imgur.com/0xeMy8Z.png"),
              ),
              Container(
                height: 50,
                child: Center(
                  child: Text("Рамзес",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: 'Alegreya',
                          fontWeight: FontWeight.w500)),
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 153 / 115,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return index != 4
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://i.imgur.com/YT3tj6H.png"),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "я размес",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 22,
                                      fontFamily: 'AlegreyaSans'),
                                ),
                              ),
                            ))
                        : Container(
                            child: Align(alignment: Alignment.center, child: Icon(Icons.add,size: 42, color: Colors.white,),),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(106, 174, 114, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          );
                  })
            ],
          ),
        )),
      ),
    );
  }
}
