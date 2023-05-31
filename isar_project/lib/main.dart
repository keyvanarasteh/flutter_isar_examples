import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar_project/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.black,
          shadowColor: Colors.grey,
          systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: Colors.black,
          )
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor: Colors.black,
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}