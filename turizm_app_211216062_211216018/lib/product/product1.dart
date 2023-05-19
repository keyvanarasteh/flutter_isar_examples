import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Transitions extends StatelessWidget {
  final Icon iconn;
  final String text;

  const Transitions({
    Key? key,
    required this.iconn,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 45, 47, 57),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: iconn,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//