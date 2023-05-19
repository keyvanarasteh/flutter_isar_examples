import 'package:film_add/db/cost.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:film_add/db/income.dart';

import 'package:film_add/widgets/customAppbar2.dart';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class linecharts extends StatefulWidget {
  final String? username;
  final String? name;
  const linecharts({super.key, this.username, this.name});

  @override
  State<linecharts> createState() => _linechartsState();
}

class _linechartsState extends State<linecharts> {
  final List<ChartData> _data = []; //aylık gelir gösterimi
  final List<ChartData> _data2 = []; //aylık gider gösterimi
  late Isar isar;
  num giderler = 0;
  num gelirler = 0;
  double gelir_ocak = 0;
  double gider_ocak = 0;
  double gelir_subat = 0;
  double gider_subat = 0;
  double gelir_mart = 0;
  double gider_mart = 0;
  double gelir_nisan = 0;
  double gider_nisan = 0;
  double gelir_mayis = 0;
  double gider_mayis = 0;
  double gelir_haziran = 0;
  double gider_haziran = 0;
  double gelir_temmuz = 0;
  double gider_temmuz = 0;
  double gelir_agustos = 0;
  double gider_agustos = 0;
  double gelir_eylul = 0;
  double gider_eylul = 0;
  double gelir_ekim = 0;
  double gider_ekim = 0;
  double gelir_kasim = 0;
  double gider_kasim = 0;
  double gelir_aralik = 0;
  double gider_aralik = 0;
  gelir_1() async {
    gelir_ocak = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('January')
        .findAll();
    for (var i in ggelir) {
      gelir_ocak += i.draw!;
    }

    setState(() {});
  }

  gider_1() async {
    gider_ocak = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('January')
        .findAll();
    for (var i in ggider) {
      gider_ocak += i.outgo!;
    }

    setState(() {});
  }

  gelir_2() async {
    gelir_subat = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('February')
        .findAll();
    for (var i in ggelir) {
      gelir_subat += i.draw!;
    }

    setState(() {});
  }

  gider_2() async {
    gider_subat = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('February')
        .findAll();
    for (var i in ggider) {
      gider_subat += i.outgo!;
    }

    setState(() {});
  }

  gelir_3() async {
    gelir_mart = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('March')
        .findAll();
    for (var i in ggelir) {
      gelir_mart += i.draw!;
    }

    setState(() {});
  }

  gider_3() async {
    gider_mart = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('March')
        .findAll();
    for (var i in ggider) {
      gider_mart += i.outgo!;
    }

    setState(() {});
  }

  gelir_4() async {
    gelir_nisan = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('April')
        .findAll();
    for (var i in ggelir) {
      gelir_nisan += i.draw!;
    }

    setState(() {});
  }

  gider_4() async {
    gider_nisan = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('April')
        .findAll();
    for (var i in ggider) {
      gider_nisan += i.outgo!;
    }

    setState(() {});
  }

  gelir_5() async {
    gelir_mayis = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('May')
        .findAll();
    for (var i in ggelir) {
      gelir_mayis += i.draw!;
    }

    setState(() {});
  }

  gider_5() async {
    gider_mayis = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('May')
        .findAll();
    for (var i in ggider) {
      gider_mayis += i.outgo!;
    }

    setState(() {});
  }

  gelir_6() async {
    gelir_haziran = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('June')
        .findAll();
    for (var i in ggelir) {
      gelir_haziran += i.draw!;
    }

    setState(() {});
  }

  gider_6() async {
    gider_haziran = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('June')
        .findAll();
    for (var i in ggider) {
      gider_haziran += i.outgo!;
    }

    setState(() {});
  }

  gelir_7() async {
    gelir_temmuz = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('July')
        .findAll();
    for (var i in ggelir) {
      gelir_temmuz += i.draw!;
    }

    setState(() {});
  }

  gider_7() async {
    gider_temmuz = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('July')
        .findAll();
    for (var i in ggider) {
      gider_temmuz += i.outgo!;
    }

    setState(() {});
  }

  gelir_8() async {
    gelir_agustos = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('August')
        .findAll();
    for (var i in ggelir) {
      gelir_agustos += i.draw!;
    }

    setState(() {});
  }

  gider_8() async {
    gider_agustos = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('August')
        .findAll();
    for (var i in ggider) {
      gider_agustos += i.outgo!;
    }

    setState(() {});
  }

  gelir_9() async {
    gelir_eylul = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('September')
        .findAll();
    for (var i in ggelir) {
      gelir_eylul += i.draw!;
    }

    setState(() {});
  }

  gider_9() async {
    gider_eylul = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('September')
        .findAll();
    for (var i in ggider) {
      gider_eylul += i.outgo!;
    }

    setState(() {});
  }

  gelir_10() async {
    gelir_ekim = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('October')
        .findAll();
    for (var i in ggelir) {
      gelir_ekim += i.draw!;
    }

    setState(() {});
  }

  gider_10() async {
    gider_ekim = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('October')
        .findAll();
    for (var i in ggider) {
      gider_ekim += i.outgo!;
    }

    setState(() {});
  }

  gelir_11() async {
    gelir_kasim = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('November')
        .findAll();
    for (var i in ggelir) {
      gelir_kasim += i.draw!;
    }

    setState(() {});
  }

  gider_11() async {
    gider_kasim = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('November')
        .findAll();
    for (var i in ggider) {
      gider_kasim += i.outgo!;
    }

    setState(() {});
  }

  gelir_12() async {
    gelir_aralik = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('December')
        .findAll();
    for (var i in ggelir) {
      gelir_aralik += i.draw!;
    }

    setState(() {});
  }

  gider_12() async {
    gider_aralik = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .monthNameEqualTo('December')
        .findAll();
    for (var i in ggider) {
      gider_aralik += i.outgo!;
    }

    setState(() {});
  }

  @override
  void initState() {
    isar = Provider.of<Isar>(context, listen: false);
    super.initState();
    gelir_1();
    gider_1();
    gelir_2();
    gider_2();
    gelir_3();
    gider_3();
    gelir_4();
    gider_4();
    gelir_5();
    gider_5();
    gelir_6();
    gider_6();
    gelir_7();
    gider_7();
    gelir_8();
    gider_8();
    gelir_9();
    gider_9();
    gelir_10();
    gider_10();
    gelir_11();
    gider_11();
    gelir_12();
    gider_12();
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
              child: SfCartesianChart(
                  title: ChartTitle(text: "Detaylı Gelir - Gider Tablosu"),
                  primaryXAxis: CategoryAxis(arrangeByIndex: true),
                  series: <ChartSeries<ChartData, String>>[
                    ColumnSeries(
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true, showCumulativeValues: true),
                      dataSource: [
                        ChartData("Ock", gelir_ocak),
                        ChartData("Şub", gelir_subat),
                        ChartData("Mrt", gelir_mart),
                        ChartData("Nis", gelir_nisan),
                        ChartData("May", gelir_mayis),
                        ChartData("Haz", gelir_haziran),
                        ChartData("Tm", gelir_temmuz),
                        ChartData("Agt", gelir_agustos),
                        ChartData("Eyl", gelir_eylul),
                        ChartData("Ekm", gelir_ekim),
                        ChartData("Ks", gelir_kasim),
                        ChartData("Ark", gelir_aralik),
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y1,
                    ),
                    ColumnSeries(
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true, showCumulativeValues: true),
                      dataSource: [
                        ChartData("", gider_ocak),
                        ChartData("", gider_subat),
                        ChartData("", gider_mart),
                        ChartData("", gider_nisan),
                        ChartData("", gider_mayis),
                        ChartData("", gider_haziran),
                        ChartData("", gider_temmuz),
                        ChartData("", gider_agustos),
                        ChartData("", gider_eylul),
                        ChartData("", gider_ekim),
                        ChartData("", gider_kasim),
                        ChartData("", gider_aralik),
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y1,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  final String x; //ayın adı
  final double y1; //gelirdeğer

  ChartData(this.x, this.y1);
}
