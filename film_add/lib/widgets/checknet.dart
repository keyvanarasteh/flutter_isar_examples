import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckScreen extends StatefulWidget {
  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  bool _isConnected = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
      showConnectionLostDialog();
    } else {
      setState(() {
        _isConnected = true;
        GoRouter.of(context).push('/home');
      });
      startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        setState(() {
          _isConnected = false;
        });
        stopTimer();
        showConnectionLostDialog();
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void showConnectionLostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bağlantı hatası'),
          content: Text('İnternet bağlantısı kaybedildi'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                GoRouter.of(context).push('/checkwifi');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isConnected
            ? Text('İnternet bağlantısı var')
            : Text('İnternet bağlantısı yok'),
      ),
    );
  }
}
