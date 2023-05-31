// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../db/product.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
      getProducts(); // Bu metodu burada çağırın
    });
  }

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst kısım dashboard yazısı
              Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0, // updated to 30px font size
                      ),
                    ),
                    // Üst kısım lifelıne Logo
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/logom.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Productdaki priceın container içinde yazılması ve styeları
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                height: MediaQuery.of(context).size.height *
                    0.20, // 20% of screen height
                decoration: BoxDecoration(
                  color: Color(0xFF2C62FF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insights,
                          color: Colors.white,
                          size: 26.0,
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          ' ${totalPrices()} TL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Bakiye',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              //ListView.builder üstündeki son işlem ve hepsini görüntülenin boyutu ve styleları
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SON İŞLEMLER",
                        style: TextStyle(
                            color: Color.fromARGB(255, 196, 194, 194),
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () {
                        closeConnection();
                        GoRouter.of(context).push('/report');
                      },
                      child: Text(
                        "Hepsini Görüntüle",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              // ListWievdaki arka plan renk ve boyutu
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height *
                      0.45, // 20% ekranımın
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      // Ürünlerimin Listelenmesi
                      // Listem içindeki row da Gelirim ve gidere Göre ıconum
                      // Row içi column da Listemdeki  Gelir-Gider Başlığı name:Başlık Fiyat ve Tarihimin Bulunduğu column
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length > 5 ? 5 : products.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = products[index];
                          final categoryLabel =
                              product.category == 1 ? 'Gelir' : 'Gider';
                          return Padding(
                            padding: const EdgeInsets.only(left: 1.0, top: 10),
                            child: Container(
                              width: 200.0,
                              height: 100.0,
                              margin: EdgeInsets.only(right: 10.0),
                              color: Colors.white,
                              // Gelirim ve gidere Göre ıconum
                              // Row içi column da Listemdeki  Gelir-Gider Başlığı name:Başlık Fiyat ve Tarihimin Bulunduğu column

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    padding: EdgeInsets.all(7.0),
                                    child: Icon(
                                      products[index].category == 1
                                          ? Icons.add
                                          : Icons.remove,
                                      color: products[index].category == 1
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  // Listemdeki  Gelir-Gider Başlığı name:Başlık Fiyat ve Tarihimin Bulunduğu column
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 14.0),
                                      Text(
                                        products[index].category == 1
                                            ? "Gelir"
                                            : "Gider",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        product.name.toString(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        '${products[index].price} \TL',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: products[index].category == 1
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        products[index].dateAdded != null
                                            ? '${DateFormat('dd/MM/yyyy ').format(products[index].dateAdded!)}'
                                            : 'Tarih Girilmemiş',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ),
              SizedBox(height: 0.0),
            ],
          ),
        ),
      ),
    );
  }
}
