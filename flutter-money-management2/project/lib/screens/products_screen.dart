// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../db/product.dart';
import '../widgets/filled_text_field.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Isar isar;

  List<Category> categories = [];
  List<Product> products = [];
  bool addMode = true;
  String name = "";
  double price = 0.0;
  double Totalprice = 0.0;
  int? category;
  int order = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController orderController = TextEditingController();

//ürün ekleme
  addProduct() async {
    final newProduct = Product()
      ..name = name
      ..price = price
      ..category = category
      ..order = order
      ..dateAdded =
          await _selectDate(context); // Kullanıcının seçtiği tarihi atar

    await isar.writeTxn(() async {
      await isar.products.put(newProduct);

      getProducts();
    });
  }

//Ürünleri mi getir
  getProducts() async {
    products = await isar.products.where().sortByOrder().findAll();
    products = products.reversed.toList();
    setState(() {});
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    return picked;
  }

//Ürün Kaldırma
  removeProduct(int productId) async {
    await isar.writeTxn(() async {
      bool result = await isar.products.delete(productId);
      if (result) {
        getProducts();
        addMode = true;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Ürün silinemedi.'),
        ));
      }
    });
  }

// Ürüleri mi güncelleme
  updateProduct(int productId) async {
    final updatedProduct = Product()
      ..id = productId
      ..name = name
      ..price = price
      ..category = category
      ..order = order
      ..dateAdded = DateTime.now(); // güncellenme için tarihe atamada kullandım

    await isar.writeTxn(() async {
      await isar.products.put(updatedProduct);

      getProducts();
    });
  }

// Silerken uyarı buttonum
  void _showAlertDialog(BuildContext context, int productId) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Onay'),
        content: const Text('ürünü silmek istediğinizden emin misiniz?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Hayır'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              removeProduct(productId);
            },
            child: const Text('Evet'),
          ),
        ],
      ),
    );
  }

//Ürünlerimin listelendiği widget
  List<Widget> productsWidgets() {
    double totalPrice = 0;
    if (products.isEmpty) {
      return [Center(child: Text('Ürün Bulunamadi.'))];
    } else {
      return products.map((e) {
        totalPrice += e.price;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(e.name!),
              ),
              Expanded(
                flex: 1,
                child: Text(e.price.toString()),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '${e.dateAdded != null ? DateFormat('dd/MM/yyyy ').format(e.dateAdded!) : "Tarih Yok"}',
                  textAlign: TextAlign.end,
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateProduct(e.id);
                        addMode = true;
                        setState(() {});
                      },
                      child: Icon(Icons.edit_note_sharp),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        _showAlertDialog(context, e.id);
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList()
        ..add(
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        );
    }
  }

// Kategorimi getir
  getCategories() async {
    categories = await isar.categorys.where().sortByOrder().findAll();
    setState(() {});
  }

//Kategorimi Listeleme
  categoriesList() {
    return categories.map((e) {
      return DropdownMenuItem<int>(value: e.id, child: Text(e.categoryName!));
    }).toList();
  }

// Bağlantı open
  openConnection() async {
    try {
      isar = await Isar.open([ProductSchema, Product2Schema, CategorySchema]);
      getCategories();
    } catch (e) {}
    setState(() {});
  }

//bağlantı close
  closeConnection() async {
    try {
      await isar.close();
    } catch (e) {}
  }

// İnintstate Ürünleri getir bağlantıyı aç
  void initState() {
    super.initState();
    try {
      openConnection().then((_) {
        getProducts();
      });
    } catch (e) {
      print(e);
    }
  }

// Bağlantı kapama Dispose
  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar Bilgi Kısmı
      appBar: AppBar(
        title: Text('Fiyatlandırma'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  getCategories();
                },
                icon: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('    Başlık:'),
              SizedBox(height: 8),
              // Başlık Girişi
              FilledTextField(
                hint:
                    'Gelir Veya Gideri başlık halinde özetleyiniz örn: Elektirik Faturası',
                controller: nameController,
                icon: Icon(Icons.text_fields),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 8),
              Text('    Fiyat:'),
              SizedBox(height: 8),
              // Fiyat Girişi
              FilledTextField(
                hint: 'Fiyat',
                icon: Icon(Icons.money),
                controller: priceController,
                onChanged: (value) {
                  try {
                    if (value.isNotEmpty) {
                      price = double.parse(value);
                      setState(() {});
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fiyat sayi olmasi gerekli.')));
                  }
                },
              ),
              SizedBox(height: 8),

              Text('    Kategori:'),
              SizedBox(height: 8),
              // Gelir Gider Seçeneği
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      // Gelir Gider Seçeneği
                      child: DropdownButton<int>(
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text('Gelir'),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text('Gider'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            category = value;
                          });
                        },
                        value: category,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('    Siralama: '),
              SizedBox(height: 8),
              SizedBox(height: 18),
              Row(
                children: [
                  // Ekleme buttonu
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            addProduct();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text('Ekle'),
                              ],
                            ),
                          ))),
                ],
              ),
              // eklenenleri listele
              SizedBox(height: 18),
              Expanded(
                  child: ListView(
                children: productsWidgets(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
