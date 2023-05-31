import 'package:flutter/material.dart';

class ContactScreen2 extends StatefulWidget {
  final Map<String, List<String>> params;
  const ContactScreen2({super.key, required this.params});

  @override
  State<ContactScreen2> createState() => _ContactScreen2State();
}

class _ContactScreen2State extends State<ContactScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(child: Text(widget.params.toString())),
      ),
    );
  }
}
