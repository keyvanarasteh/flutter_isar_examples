import 'package:flutter/material.dart';
import 'package:flutter_odev/core/routes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:isar/isar.dart';

import 'models/cost.dart';
import 'models/income.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  await Isar.open([IncomeSchema, CostSchema]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gelir - Gider',
      routerConfig: router,
    );
  }
}
