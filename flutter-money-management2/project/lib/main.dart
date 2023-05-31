// ignore_for_file: prefer_const_constructors

import 'package:dashboard_app/screens/announcement.dart';
import 'package:dashboard_app/screens/chart.dart';
import 'package:dashboard_app/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';

import 'screens/home_screen.dart';
import 'screens/order_screen.dart';
import 'screens/products_screen.dart';
import 'screens/report_screen.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(0, 146, 172, 0.098),
  100: Color.fromRGBO(58, 61, 59, 0.2),
  200: Color.fromRGBO(19, 209, 223, 0.298),
  300: Color.fromRGBO(0, 153, 255, 0.4),
  400: Color.fromRGBO(41, 138, 151, 0.498),
  500: Color.fromRGBO(90, 136, 100, .6),
  600: Color.fromRGBO(14, 186, 216, 0.698),
  700: Color.fromRGBO(90, 136, 100, .8),
  800: Color.fromRGBO(90, 136, 100, .9),
  900: Color.fromRGBO(90, 136, 100, 1),
};

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/duyuru',
      builder: (context, state) => AnnouncementGeneral(),
    ),
    GoRoute(
      path: '/order',
      builder: (context, state) => OrderScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => ProductScreen(),
    ),
    GoRoute(
      path: '/report',
      builder: (context, state) => ReportScreen(),
    ),
    GoRoute(
      path: '/chart',
      builder: (context, state) => denemem(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => Test(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        title: 'LifeLine Spor Center',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MaterialColor(
              0xFF2C62FF, color), // Color.fromARGB(255, 90, 136, 100),
        ),
        routerConfig: _router,
      ),
    );
  }
}
