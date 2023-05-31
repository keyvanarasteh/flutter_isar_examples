import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../db/book.dart';
import '../utils/utils.dart';
import 'home_page.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class BookData {
  String name;
  int stok;
  BookData(this.name, this.stok);
}

class _ChartPageState extends State<ChartPage> {

  List<BookData> bookData = [];
  late TooltipBehavior _tooltipBehavior;

  getAllBooks() async {
    books = await isar.books.where().findAll();
    setState(() {});
  }

  openConnection() async {
    try {
      isar = await Isar.open([BookSchema]);
      if (isar.isOpen) {
        print("database ile bağlantı kuruldu");
        getAllBooks();
      }
      else {
        print("bağlantı hatası");
      }
    } catch (e) {
      print("open hatası oluştu:");
      print(e);
    }
  }

  closeConnection() async {
    try {
      var result = await isar.close();
      if (result) {
        print("bağlantı başarıyla kapatıldı");
      }
      else {
        print("bağlantı kapatılamadı");
      }
    } catch (e) {
      print("close hatası oluştu:");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    openConnection();
    addBookData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  void dispose() {
    super.dispose();
    // closeConnection();
  }

  addBookData() {
    if (books.length != 0) {
      // bookData.clear();
      for (var i = 0; i < books.length; i++) {
        bookData.add(BookData(books[i].name!, books[i].stok!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("İstatistikler"),
        ),
        body: bookData.length != 0 ? SfCircularChart(
            title: ChartTitle(
              text: "Kitapların Stok Durumu",
            ),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<BookData, String>(
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                ),
                dataSource: bookData,
                xValueMapper: (BookData data, _) => data.name,
                yValueMapper: (BookData data, _) => data.stok,
                enableTooltip: true,
              ),
            ],
          ) : Center(child: Text("Kitaplar listesi boş!", style: Theme.of(context).textTheme.titleLarge)),
      ),
    );
  }
}