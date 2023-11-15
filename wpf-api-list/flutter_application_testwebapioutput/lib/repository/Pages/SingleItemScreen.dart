import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';

class SignleItemScreen extends StatefulWidget {
  final Item item;
  SignleItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<SignleItemScreen> createState() => _SignleItemScreenState();
}

class _SignleItemScreenState extends State<SignleItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.item.item_image![0] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                    stops: [0.0, 0.1, 0.9, 1.0],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 600,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(this.widget.item.item_name! ,style: TextStyle(color: Colors.white, fontSize: 48,),softWrap: false, overflow: TextOverflow.fade,),
                          Text("Купи " + this.widget.item.item_name! ,style: TextStyle(color: Colors.white, fontSize: 24,),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(36)),
                      onTap: () => print("ad"),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("Take ${this.widget.item.item_name!}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                        ),
                    ),
                  ),
                  
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
