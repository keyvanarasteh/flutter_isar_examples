import 'package:film_add/db/Users.dart';
import 'package:film_add/db/cost.dart';
import 'package:film_add/db/income.dart';
import 'package:film_add/home.dart';
import 'package:film_add/register.dart';
import 'package:film_add/screen/add_cost.dart';
import 'package:film_add/screen/add_money.dart';
import 'package:film_add/screen/edit_user.dart';
import 'package:film_add/screen/main_screen.dart';
import 'package:film_add/widgets/checknet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

void main() async {
  final isar = await openIsar();
  runApp(
    Provider.value(
      value: isar,
      child: const MyApp(),
    ),
  );
}

Future<Isar> openIsar() async {
  final isar = await Isar.open(
    [UserSchema, IncomeSchema, CostSchema],
  );
  return isar;
}

final _router = GoRouter(
  initialLocation: '/checkwifi',
  routes: [
    GoRoute(
      path: '/checkwifi',
      builder: (context, state) => CheckScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => Register(),
    ),
    GoRoute(
      path: '/screen1',
      builder: (context, state) => mScreen(),
    ),
    GoRoute(
      path: '/screen2',
      builder: (context, state) => addincome(),
    ),
    GoRoute(
      path: '/screen3',
      builder: (context, state) => addCost(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => edituser(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
