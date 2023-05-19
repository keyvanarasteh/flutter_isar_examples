import 'package:databaseodev/database/library.dart';
import 'package:databaseodev/database/person.dart';
import 'package:databaseodev/screen/bookUpdate.dart';
import 'package:databaseodev/screen/chart_screen.dart';
import 'package:databaseodev/screen/listBook.dart';
import 'package:databaseodev/screen/mainPage.dart';
import 'package:databaseodev/screen/oduncKitap.dart';
import 'package:databaseodev/screen/person.dart';
import 'package:databaseodev/screen/secondpage.dart';
import 'package:databaseodev/screen/userUpdate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  final isar = await openIsar();
  runApp(Provider.value(value: isar, child: const MyApp()));
}

final _router = GoRouter(
  initialLocation: '/MainPage',
  routes: [
    GoRoute(
      name: '/mainPage',
      path: '/MainPage',
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      name: '/chartScreen',
      path: '/chartScreen',
      builder: (context, state) => ChartScreen(),
    ),
    GoRoute(
      path: '/secondPage',
      name: '/secondPage',
      builder: (context, state) => SecondPage(),
    ),
    GoRoute(
      path: '/listBook',
      name: '/listBook',
      builder: (context, state) => ListBook(),
    ),
    GoRoute(
      path: '/oduncKitap',
      name: '/oduncKitap',
      builder: (context, state) => OduncKitap(),
    ),
    GoRoute(
      name: '/oduncAlan',
      path: '/oduncAlan',
      builder: (context, state) => OduncAlan(),
    ),
    GoRoute(
      path: '/userUpdate/:name/:surname/:phone/:date/:tc/:id/:book',
      name: 'userUpdate',
      builder: (context, state) {
        return UserUpdate(
            name: state.params['name']!,
            surname: state.params['surname']!,
            phone: state.params['phone']!,
            date: state.params['date']!,
            tc: state.params['tc']!,
            id: int.parse(state.params['id']!),
            book: state.params['book']!);
      },
    ),
    GoRoute(
      name: 'bookUpdate',
      path: '/bookUpdate/:bookName/:writerName/:pageCount/:date/:id',
      builder: (context, state) => BookUpdate(
        bookName: state.params['bookName'],
        writerName: state.params['writerName'],
        pageCount: state.params['pageCount'],
        date: state.params['date'],
        id: int.parse(state.params['id']!),
      ),
    ),
  ],
);
Future<Isar> openIsar() async {
  final isar = await Isar.open([LibrarySchema, PersonSchema]);
  return isar;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        // routes: {
        //   '/secondPage': (context) => SecondPage(),
        //   '/listUser': (context) => ListBook(),
        //   '/oduncKitap': (context) => OduncKitap(),
        //   '/oduncAlanlar': (context) => OduncAlan(),
        // },
      ),
    );
  }
}
