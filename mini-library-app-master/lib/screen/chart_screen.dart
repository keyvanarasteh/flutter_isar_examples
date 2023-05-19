import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:databaseodev/database/person.dart';
import 'package:databaseodev/widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late Isar isar;
  late List<_ChartData> chartData = [];
//   double localTotalCount = 0;

  @override
  void initState() {
    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
    getRecordCountByDate2().then((data) {
      setState(() {
        List<MapEntry<String, int>> dataList = data.entries.toList();
        // Listeyi küçükten büyüğe sıralıyoruz
        dataList.sort((a, b) => a.key.compareTo(b
            .key)); //Burada a.key ve b.key değerlerini karşılaştırıp küçük olanı önce alıyor.String veriler için kullanırız.
        chartData = dataList
            .map((entry) => _ChartData(entry.key, entry.value))
            .toList();
      });
    });
    // totalCountCalc().then((count) {
    //   setState(() {
    //     localTotalCount = count;
    //   });
    // });
  }

//   Future<double> totalCountCalc() async {
//     final records2 = await isar.persons.where().findAll();
//     final double totalCount = records2.length.toDouble();
//     print(totalCount);
//     return totalCount;
//   }

  Future<Map<String, int>> getRecordCountByDate2() async {
    final records = await isar.persons.where().findAll();

    final recordMap = <String, int>{};
    for (var record in records) {
      final date = record.date!;
      recordMap.update(date, (count) => count + 1, ifAbsent: () => 1);
    }
    return recordMap;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
          path: '/mainPage',
        ),
        body: chartData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Henüz Kütüphaneden Kitap Alımı Gerçekleşmemiştir."),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("images/online-library1.png"),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Grafik ",
                          style: GoogleFonts.bebasNeue(fontSize: 36)),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: MyPadding.all,
                        child: Container(
                          height: 400,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: MyPadding.all,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              // appColors.chartColor,
                              // appColors.chartColor2,
                              Color(0xFFECE9E6),
                              Color(0xFFFFFFFF),
                            ]),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Expanded(
                            child: SfCartesianChart(
                              title: ChartTitle(
                                  text: 'Kitapların Alındığı Tarih Grafiği',
                                  textStyle:
                                      GoogleFonts.bebasNeue(fontSize: 18)),
                              legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              primaryXAxis: CategoryAxis(
                                axisLine: AxisLine(width: 1),
                                labelStyle: TextStyle(fontSize: 12),
                                interval: 1,
                              ),
                              primaryYAxis: NumericAxis(
                                axisLine: AxisLine(width: 1),
                                labelStyle: TextStyle(fontSize: 12),
                                minimum: 0,
                                maximum: 10,
                              ),
                              series: <SplineAreaSeries<_ChartData, String>>[
                                SplineAreaSeries<_ChartData, String>(
                                  splineType: SplineType.natural,
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  name: "Alım Tarihleri",
                                  gradient: LinearGradient(colors: [
                                    // appColors.chartColor,
                                    // appColors.chartColor2,
                                    Color(0xFFD3CCE3),
                                    Color(0xFFE9E4F0),
                                  ]),
                                  borderColor: Colors.black12,
                                  borderWidth: 2,
                                  borderDrawMode: BorderDrawMode.excludeBottom,
                                  dataSource: chartData,
                                  xValueMapper: (_ChartData data, _) =>
                                      data.date,
                                  yValueMapper: (_ChartData data, _) =>
                                      data.count,
                                  animationDuration: 1000,
                                  dataLabelSettings: DataLabelSettings(
                                    textStyle: TextStyle(fontSize: 12),
                                    labelAlignment:
                                        ChartDataLabelAlignment.middle,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.date, this.count);
  final String date;
  final int count;
}
