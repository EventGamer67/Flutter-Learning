import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/SingleItemScreen.dart';

import '../models/Item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({super.key, required this.item});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(item.item_image![0] ?? ''), 
          fit: BoxFit.cover, 
      ),
      ),
      child: InkWell(
          onTap: () { print("asd"); Navigator.push(context, MaterialPageRoute(builder: (context) => SignleItemScreen(item:item) ) ); },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.item_name ?? ' ', style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),textAlign: TextAlign.center,)
          ]
           ),
      ),);
  }
}