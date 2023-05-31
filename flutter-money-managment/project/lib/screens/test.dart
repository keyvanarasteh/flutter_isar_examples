import 'package:dashboard_app/widgets/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../db/product.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class Sale {
  String date = "";
  int price = 0;
}

class ChartData {
  final DateTime? dateAdded;
  final double price;

  ChartData({required this.dateAdded, required this.price});
}

class _TestState extends State<Test> {
  void checkInternetConnection() {
    Internet().checkInternetCon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: checkInternetConnection,
                  child: Text('İnternet Bağlantımı Kontrol Et'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
