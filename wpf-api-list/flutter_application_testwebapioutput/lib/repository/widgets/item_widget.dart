import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key, required Item});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: (150/195),
      children: [
        for (int i = 0; i < 10; i++ )
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white.withOpacity(1.0),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 1,blurRadius: 8)]
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset('name', width: 120, height: 120, fit: BoxFit.contain,),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jopa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text("Cena Jopi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
                )
              ]
            ),
          )
      ],
      );
  }
}