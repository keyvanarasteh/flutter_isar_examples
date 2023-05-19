import 'package:flutter/material.dart';

class infoName extends StatelessWidget {
  final String? name;
  const infoName({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Hi",
                    style: TextStyle(fontSize: 34),
                  ),
                  Text(
                    " $name!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Güne hazır mısın?",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
