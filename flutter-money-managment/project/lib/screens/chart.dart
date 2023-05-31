import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../db/product.dart';

class denemem extends StatefulWidget {
  const denemem({Key? key}) : super(key: key);

  @override
  State<denemem> createState() => _denememState();
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

class _denememState extends State<denemem> {
  Isar? isar;
  List<Product> products = [];
  List<Product> products2 = [];

  bool addMode = true;
  String name = "";
  double price = 0.0;
  double Totalprice = 0.0;
  int? category;
  int order = 0;

  double totalPrices() {
    double total = 0.0;
    for (var product in products) {
      if (product.category == 1) {
        total += product.price;
      } else if (product.category == 2) {
        total -= product.price;
      }
    }
    return total;
  }

  addProduct() async {
    final newProduct = Product()
      ..name = name
      ..price = price
      ..category = category
      ..order = order;

    // null check
    if (isar != null) {
      await isar!.writeTxn(() async {
        await isar!.products.put(newProduct);
        await getProducts();
      });
    }
  }

  getProducts() async {
    if (isar != null) {
      products = await isar!.products.where().sortByOrder().findAll();
      products = products.reversed.toList();
      setState(() {
        Totalprice = totalPrices();
      });
    }
  }

  Future<List<Product>> getproducts() async {
    if (isar != null) {
      final productslist = await isar!.products
          .filter()
          .dateAddedBetween(startDate!, endDate!,
              includeUpper: true, includeLower: true)
          .findAll();
      return productslist;
    } else {
      return [];
    }
  }

  openConnection() async {
    try {
      isar = await Isar.open([ProductSchema, Product2Schema, CategorySchema]);
      setState(() {});
    } catch (e) {
      // Hata işleme
    }
  }

  closeConnection() async {
    if (isar != null) {
      try {
        await isar!.close();
      } catch (e) {
        // Hata işleme
      }
    }
  }

  getProductsByDateRange() async {
    if (isar != null) {
      var query = isar!.products;

      // Tarih aralığına göre filtreleme yapar ve Tarih aralığına göre filtrelenen ürünleri alır

      products2 = await query
          .filter()
          .dateAddedBetween(startDate!, endDate!)
          .sortByOrder()
          .findAll();

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    openConnection().then((_) {
      getProducts();
    });
  }

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }

  bool linechart = true;
  bool circlechart = true;
  bool timeselect = false;
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Grafiği"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SfDateRangePicker(
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: (e) {
                    PickerDateRange x = e.value;
                    if (x.startDate != null && x.endDate != null) {
                      startDate = x.startDate!;
                      endDate = x.endDate!;
                    } else if (x.startDate != null && x.endDate == null) {
                      startDate = x.startDate!;
                    } else {
                      startDate = null;
                      endDate = null;
                    }
                    getProductsByDateRange();
                    setState(() {});
                  },
                ),
                FutureBuilder<List<Product>>(
                  future: getproducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final List<ChartData> chartDataCategory1 = snapshot.data!
                          .where((product) => product.category == 1)
                          .map((product) => ChartData(
                              dateAdded: product.dateAdded,
                              price: product.price))
                          .toList();

                      final List<ChartData> chartDataCategory2 = snapshot.data!
                          .where((product) => product.category == 2)
                          .map((product) => ChartData(
                              dateAdded: product.dateAdded,
                              price: product.price))
                          .toList();

                      return SfCartesianChart(
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<ChartData, String>>[
                          LineSeries(
                            name: "Gelir",
                            dataSource: chartDataCategory1,
                            color: Colors.green,
                            xValueMapper: (ChartData sell, _) =>
                                DateFormat('dd MMM yyyy').format(
                                    DateTime.parse(sell.dateAdded.toString())),
                            yValueMapper: (ChartData sell, _) => sell.price,
                          ),
                          LineSeries(
                            name: "Gider",
                            dataSource: chartDataCategory2,
                            color: Colors.red,
                            xValueMapper: (ChartData sell, _) =>
                                DateFormat('dd MMM yyyy').format(
                                    DateTime.parse(sell.dateAdded.toString())),
                            yValueMapper: (ChartData sell, _) => sell.price,
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
