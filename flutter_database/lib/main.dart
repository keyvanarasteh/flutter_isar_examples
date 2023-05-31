// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'screens/about_screen.dart';
import 'screens/chart_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/contact_screen2.dart';
import 'screens/costs.screen.dart';
import 'screens/date.screen.dart';
import 'screens/earn_screen.dart';
import 'screens/error_screen.dart';
import 'screens/home_screen.dart';
import 'screens/information_screen.dart';
import 'screens/news.screen.dart';
import 'screens/products_screen.dart';
import 'screens/user_screen.dart';
import 'screens/users_screen.dart';

void main() {
  // Web url sorununun çözümü
  usePathUrlStrategy();
  runApp(const MyApp());
}

final _routes = GoRouter(
  initialLocation: '/home',
  errorBuilder: (context, state) => ErrorScreen(),
  routes: [
    GoRoute(
      path: '/earn',
      builder: (context, state) => EarnScreen(),
    ),
    GoRoute(
      path: '/chart',
      builder: (context, state) => ChartScreen(),
    ),
    GoRoute(
      path: '/date',
      builder: (context, state) => DateScreen(),
    ),
    GoRoute(
      path: '/cost',
      builder: (context, state) => CostsScreen(),
    ),
    GoRoute(
      path: '/information',
      builder: (context, state) => InfoScreen(),
    ),
    GoRoute(
      path: '/error',
      builder: (context, state) => ErrorScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => ContactScreen(params: state.queryParams),
    ),
    GoRoute(
      path: '/contact2',
      builder: (context, state) =>
          ContactScreen2(params: state.queryParametersAll),
    ),
    GoRoute(
      path: '/news',
      builder: (context, state) => NewsScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => ProductsScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => UsersScreen(),
    ),
    GoRoute(
      path: '/user/:id',
      builder: (context, state) => UserScreen(userID: state.params["id"]!),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
