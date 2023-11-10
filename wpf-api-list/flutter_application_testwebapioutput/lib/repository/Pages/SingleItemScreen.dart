import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';

class SignleItemScreen extends StatefulWidget {
  final Item item;
  SignleItemScreen({super.key, required this.item});

  @override
  State<SignleItemScreen> createState() => _SignleItemScreenState();
}

class _SignleItemScreenState extends State<SignleItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              Container(
                height: 300,
                alignment: Alignment.center,child: 
                Image(image: NetworkImage(widget.item.item_image![0] ?? '' ),
                fit: BoxFit.cover,
                )),
              const SizedBox(height: 20,),
              Text(widget.item.item_name ?? 'None'),
            ],
          ),
        )
    );
  }
}