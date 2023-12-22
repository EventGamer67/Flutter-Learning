// ignore_for_file: file_names

import 'package:diplom/Models/DatabaseClasses/otherUser.dart';
import 'package:flutter/material.dart';

class AuthorCourseTile extends StatelessWidget {
  final OtherUser author;
  const AuthorCourseTile({super.key,required this.author});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Автор", style: TextStyle( fontFamily: 'Comic Sans', fontSize: 22 ) ),
          const SizedBox(height: 10,),
          Row(
            children: [
              CircleAvatar(
                radius: 36,
                foregroundImage: NetworkImage(author.avatarURL),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(author.name,style: const TextStyle( fontFamily: 'Comic Sans', fontSize: 18)),
                  const Text("Администратор",style: TextStyle( fontFamily: 'Comic Sans', fontSize: 16 ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}