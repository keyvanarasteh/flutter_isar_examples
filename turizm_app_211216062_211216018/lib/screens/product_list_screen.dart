// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import '../db/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Isar isar;

  List<Category> categories = [];
  List<Product> products = [];
  bool addMode = true;
  String name = "";
  int price = -1;
  int? category;
  int order = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController orderController = TextEditingController();

  addProduct() async {
    final newProduct = Product()
      ..name = name
      ..price = price
      ..category = category
      ..order = order;

    await isar.writeTxn(() async {
      await isar.products.put(newProduct);

      getProducts();
    });
  }

  getProducts() async {
    final productslist = await isar.products.where().findAll();
    products = productslist;
    setState(() {});
  }

 
  usersToWidget() {
    return products.map((e) {
      final category = categories.firstWhere((c) => c.id == e.category);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 45, 47, 57),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
            child: Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Text(category.categoryname.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 30,
                  child: Text(e.name.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 30,
                  child: Text(e.price.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 30,
                  child: Text(e.category.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 15,
                  child: Text(e.order.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  

  getCategories() async {
    categories = await isar.categorys.where().sortByOrder().findAll();
    setState(() {});
  }

  categoriesList() {
    return categories.map((e) {
      return DropdownMenuItem<int>(
          value: e.id,
          child: Text(
            e.categoryname!,
            style: TextStyle(color: Colors.black),
          ));
    }).toList();
  }

  openConnection() async {
    try {
      isar = await Isar.open([CategorySchema, ProductSchema]);
      getCategories();
    } catch (e) {}
    setState(() {});
  }

  closeConnection() async {
    try {
      await isar.close();
    } catch (e) {}
  }

  @override
  void initState() {
    openConnection();
    super.initState();
  }

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF1D2024),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => GoRouter.of(context).pop('/home'),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white24,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 45, 47, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: getProducts,
                        child: Text("Bilet Listele")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 45, 47, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: getProducts,
                        child: Text(" A Firma Uçuşları")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 45, 47, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: getProducts,
                        child: Text(" B Firma Biletleri")),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 45, 47, 57),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 2, bottom: 2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 30,
                          child: Text(
                            "Firma Adı",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 30,
                          child: Text(
                            "Şehir",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 24,
                          child: Text(
                            "Fiyat",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 27,
                          child: Text(
                            "Firma Id",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 25,
                          child: Text(
                            "Şehir Sırası",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                children: usersToWidget(),
              ))
            ],
          )),
    ));
  }
}
