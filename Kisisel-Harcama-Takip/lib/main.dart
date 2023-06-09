import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:kisisel_takip/pages/root_app.dart';
import 'package:kisisel_takip/scoped_model/sema.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ExpenseModel myExpenseModel = ExpenseModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ExpenseModel>(
      model: myExpenseModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootApp(),
      ),
    );
  }
}
