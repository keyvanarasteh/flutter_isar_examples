// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vizeproject/screens/CalendarScreen.dart';
import 'package:vizeproject/screens/CarSalesScreen.dart';
import 'package:vizeproject/screens/CarTransactionsScreen.dart';
import 'package:vizeproject/screens/ChartScreen.dart';
import 'package:vizeproject/screens/EntranceScreen.dart';
import 'package:vizeproject/screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

  final _router = GoRouter(
    initialLocation: '/enter',
  routes: [
     GoRoute(
      path: '/enter',
      builder: (context, state) => EntranceScreen(),
    ),    
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),  
     GoRoute(
      path: '/cartransactions',
      builder: (context, state) => CarTransactionsScreen(),
    ),    
    GoRoute(
      path: '/carsales',
      builder: (context, state) => CarSalesScreen(),
    ),  
    GoRoute(
      path: '/calendar',
      builder: (context, state) => Calendarscreen(),
    ),   
     GoRoute(
      path: '/chart',
      builder: (context, state) => CharScreen(),
    ),    
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
    );
  }
}

