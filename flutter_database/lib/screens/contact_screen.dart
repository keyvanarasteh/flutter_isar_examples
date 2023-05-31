import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  final Map<String, String> params;
  const ContactScreen({super.key, required this.params});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
