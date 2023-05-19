import 'package:film_add/db/cost.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:film_add/db/income.dart';

import 'package:film_add/widgets/customAppbar2.dart';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class charts extends StatefulWidget {
  final String? username;
  final String? name;
  const charts({super.key, this.username, this.name});

  @override
  State<charts> createState() => _chartsState();
}

class _chartsState extends State<charts> {
  late Isar isar;
  num giderler = 0;
  num gelirler = 0;
  gelir() async {
    gelirler = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in ggelir) {
      gelirler += i.draw!;
    }

    setState(() {});
  }

  gider() async {
    giderler = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in ggider) {
      giderler += i.outgo!;
    }

    setState(() {});
  }

  @override
  void initState() {
    isar = Provider.of<Isar>(context, listen: false);
    super.initState();
    gelir();
    gider();
  }

  TextEditingController moneyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 220, 244, 1),
      body: ListView(
        children: [
          Column(
            children: [
              customAppbar2(
                  username: widget.username,
                  name: widget.name,
                  leftIcon: Icons.arrow_back_ios_new,
                  rightIcon: Icons.manage_accounts_outlined),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
                height: 600,
                child: SfCircularChart(
                  margin: EdgeInsets.only(right: 100),
                  title: ChartTitle(
                      text: "Gelir-Gider Tablosu",
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                        explode: true,
                        explodeIndex: 0,
                        explodeOffset: '5%',
                        dataSource: [
                          ChartData("Gelir", gelirler.toDouble(), Colors.black),
                          ChartData("Gider", giderler.toDouble(), Colors.white)
                        ],
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        startAngle: 90,
                        endAngle: 90,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
    this.color,
  );
  final String x;
  final double y;
  final Color color;
}
