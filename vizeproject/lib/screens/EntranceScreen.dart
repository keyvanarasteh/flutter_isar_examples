// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class EntranceScreen extends StatelessWidget {
  const EntranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(flex: 18,
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/car1.jpeg'),
                fit: BoxFit.cover,
              ),
            ),),
        ),
            Expanded(flex: 2,
            child: ElevatedButton(
             style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
             onPressed: (() {
             GoRouter.of(context).push('/home');
             }),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("    Devam   Et"
                 ),
                 Icon(Icons.arrow_forward)
               ],
             )
             ),
          ),
      ],
    ); 
           
  }
}
