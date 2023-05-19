// ignore_for_file: prefer_const_constructors,

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/rangepicker_screen.dart';
import 'screens/test_screen.dart';
import 'screens/products_screen.dart';
import 'screens/libraries_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/home_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/information.dart';
import 'screens/chart.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => Home()),
    GoRoute(path: '/libraries', builder: (context, state) => LibScreen()),
    GoRoute(path: '/list', builder: (context, state) => ProductList()),
    GoRoute(path: '/product', builder: (context, state) => ProductScreen()),
    GoRoute(path: '/test', builder: (context, state) => TestScreen()),
    GoRoute(
        path: '/categories', builder: (context, state) => CategoriesScreen()),
    GoRoute(path: '/rangepicker', builder: (context, state) => RangePicker()),
    GoRoute(path: '/information', builder: (context, state) => Information()),
    GoRoute(path: '/chart', builder: (context, state) => Chart()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
