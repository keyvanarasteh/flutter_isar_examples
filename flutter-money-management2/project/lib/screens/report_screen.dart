// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../db/product.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Isar? isar;
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> products2 = [];
  bool addMode = true;
  String name = "";
  double price = 0.0;
  double Totalprice = 0.0;
  int? category;
  int order = 0;

  //Hesaplama
  double totalPrices() {
    double total = 0.0;
    for (var product in products) {
      if (product.category == 1) {
        total += product.price;
      } else if (product.category == 1) {
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
      ..order = order
      ..dateAdded =
          DateTime.now(); // Yeni ürünün tarihini şu anki zamana ayarlar.

    // null check ekleniyor
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

  openConnection() async {
    try {
      isar = await Isar.open([ProductSchema, Product2Schema, CategorySchema]);
      setState(() {});
    } catch (e) {
      // Hata işleme
    }
  }

  closeConnection() async {
    // null check ekleniyor
    if (isar != null) {
      try {
        await isar!.close();
      } catch (e) {
        // Hata işleme
      }
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

  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürünleri Görüntüleme'),
      ),
      body: SafeArea(
        child: Column(
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
                getProductsByDateRange(); // Arama fonksiyonu burada çağrılıyor
                setState(() {});
              },
            ),
            Row(
              children: [
                Text(
                  'Başlangıç Tarihi:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                if (startDate != null)
                  Text(DateFormat('  E d MMMM yyyy  ').format(startDate!))
                else
                  Text('Seçilmedi'),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Bitiş Tarihi:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                if (endDate != null)
                  Text(DateFormat('  E d MMMM yyyy  ').format(endDate!))
                else
                  Text('Seçilmedi'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products2.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 8),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200),
                              child: products2[index].category == 1
                                  ? Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    products2[index].category == 1
                                        ? "Gelir"
                                        : "Gider",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(products2[index].name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade600)),
                                ),
                                Text(
                                    products2[index].price.toStringAsFixed(2) +
                                        " TL",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: products2[index].category == 1
                                          ? Colors.green
                                          : Colors.red,
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    products2[index]
                                        .dateAdded
                                        .toString()
                                        .substring(0, 16),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
