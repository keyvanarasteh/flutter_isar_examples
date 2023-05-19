import 'package:flutter/material.dart';
import 'package:kisisel_takip/scoped_model/sema.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gelirler Gostergesi',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: StatsPageG(title: 'Gelirler'),
    );
  }
}

class StatsPageG extends StatefulWidget {
  StatsPageG(
      {Key key, this.title, Function(int index) callback, ExpenseModel model})
      : super(key: key);


  final String title;

  @override
  _StatsPageGState createState() => _StatsPageGState();
}

class _StatsPageGState extends State<StatsPageG> {
  List<SalesData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
      title: ChartTitle(text: 'Yillik Gelirler'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<SalesData, double>(
            name: 'Gelirler',
            dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}M',
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    )));
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
