import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Center(
              child: Column(
            children: [
              Text('404 Not Found'),
              ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement('/home');
                  },
                  child: Text('Ana Sayfa'))
            ],
          ))),
    );
  }
}
