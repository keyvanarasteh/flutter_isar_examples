import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar_project/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkInternetConnection(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Bağlantı bulunamadı!", textAlign: TextAlign.center),
              content: Text("İnternet bağlantısı bulunmamaktadır. Lütfen internet bağlantınızı kontrol edin ya da yeniden bağlanmayı deneyin.", textAlign: TextAlign.center),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Çıkış"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Yeniden Dene"),
                  onPressed: () {
                    Navigator.pop(context);
                    checkInternetConnection(context);
                  },
                )
              ],
            );
          },
        );
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return HomePage(); 
        }));
      }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () { 
      checkInternetConnection(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(shadowColor: Colors.black),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/book_animation.gif",
              width: 250,
            ),
            Container(
              width: 100,
              child: LinearProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}