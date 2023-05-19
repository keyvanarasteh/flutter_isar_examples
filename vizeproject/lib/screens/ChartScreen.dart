// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CharScreen extends StatefulWidget {
  const CharScreen({super.key});

  @override
  State<CharScreen> createState() => _CharScreenState();
}

class SalesData  {
  String date = "";
  double amount = 0.0;
  SalesData(this.date,this.amount);
}

class _CharScreenState extends State<CharScreen> {

  @override
  Widget build(BuildContext context) {
     return SafeArea(child: Scaffold(
        body: Column(children: [
           SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource:  <SalesData>[
                  SalesData('Hyundai', 35),
                  SalesData('Honda', 28),
                  SalesData('Audi', 34),
                  SalesData('Mercedes', 32),
                  SalesData('BMW', 40)
                ],
                xValueMapper: (SalesData sales, _) => sales.date,
                yValueMapper: (SalesData sales, _) => sales.amount
              )
            ]
          ),
          SizedBox(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        context.push('/home');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Menü Ekranına Dön"
                          ),
                           Icon(Icons.arrow_back,size: 35,)
                        ],
                      )
                      ),
        ],),
      )
     );
  }
}