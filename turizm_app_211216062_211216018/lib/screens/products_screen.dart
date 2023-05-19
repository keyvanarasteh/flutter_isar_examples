// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import '../db/product.dart';

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
  int price = -1;
  int? category;
  int order = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController orderController = TextEditingController();

  
  
  addProduct() async {
    if (name.isEmpty || price == -1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Sehir ve fiyat girmeniz gerekiyor'),
      ));
    } else {
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
  }

  getProducts() async {
    products = await isar.products.where().sortByOrder().findAll();
    setState(() {});
  }

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

  List<Widget> productsWidgets() {
    if (products.isEmpty) {
      return [
        Center(
            child: Text(
          'Ürün Bulunamadi.',
          style: TextStyle(color: Colors.white),
        ))
      ];
    } else {
      return products
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 45, 47, 57),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 2, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            e.name!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            e.price.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            e.order.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 240, 180, 150),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    minimumSize: Size(30, 30),
                                  ),
                                  onPressed: () {
                                    addMode = false;
                                    name = e.name!;
                                    order = e.order;
                                    nameController =
                                        TextEditingController(text: e.name!);
                                    orderController = TextEditingController(
                                        text: e.order.toString());
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 240, 180, 150),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    minimumSize: Size(30, 30),
                                  ),
                                  onPressed: () {
                                    _showAlertDialog(context, e.id);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    size: 20,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
          .toList();
    }
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
            style: TextStyle(color: Colors.white),
          ));
    }).toList();
  }

  openConnection() async {
    try {
      isar = await Isar.open([CategorySchema, ProductSchema,FlightpriceSchema]);
      getCategories();
      getProducts();
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

  usersToWidget() {
    return products.map((e) {
      final category = categories.firstWhere((c) => c.id == e.category);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(category.categoryname.toString(), style: TextStyle(color: Colors.red)),
                SizedBox(width: 5,),
                Text(e.name.toString(), style: TextStyle(color: Colors.red)),
                SizedBox(width: 5,),
                Text(e.price.toString(), style: TextStyle(color: Colors.red)),
                SizedBox(width: 5,),
                Text(e.category.toString(), style: TextStyle(color: Colors.red)),
                SizedBox(width: 5,),
                Text(e.order.toString(), style: TextStyle(color: Colors.red)),                      
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  
  getproduct() async {
    final pro = await isar.products.where().findAll();
    products = pro;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 29, 32, 36),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
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
                  ),
                  Expanded(
                    flex: 9,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          'Biletler',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Sehir:',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              TextField(
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                  prefixIcon: Icon(Icons.text_fields),
                  prefixIconColor: Color.fromARGB(255, 80, 80, 90),
                  hintText: 'Sehir',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 80, 80, 90)),
                  filled: true,
                  fillColor: Color.fromARGB(143, 45, 47, 57),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Fiyat:',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              TextField(
                controller: priceController,
                onChanged: (sayi) {
                  try {
                    if (sayi.isNotEmpty) {
                      price = int.parse(sayi);
                      setState(() {});
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fiyat sayi olmasi gerekli.')));
                  }
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                  prefixIcon: Icon(Icons.money),
                  prefixIconColor: Color.fromARGB(255, 80, 80, 90),
                  hintText: 'Fiyat',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 80, 80, 90)),
                  filled: true,
                  fillColor: Color.fromARGB(143, 45, 47, 57),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Firmalar:',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<int>(
                        dropdownColor: Color.fromARGB(255, 45, 47, 57),
                        isExpanded: true,
                        items: categoriesList(),
                        onChanged: (_) {
                          setState(() {
                            category = _;
                          });
                        },
                        value: category,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Siralama: ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                controller: orderController,
                onChanged: (value) {
                  try {
                    if (value.isNotEmpty) {
                      order = int.parse(value);
                    } else {
                      order = 0;
                    }
                    setState(() {});
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Siralama sayi olmasi gerekli.')));
                  }
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                  prefixIcon: Icon(Icons.sort),
                  prefixIconColor: Color.fromARGB(255, 80, 80, 90),
                  hintText: 'Firma Sıralaması',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 80, 80, 90)),
                  filled: true,
                  fillColor: Color.fromARGB(143, 45, 47, 57),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 45, 47, 57),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              addProduct();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  Text('Ekle'),
                                ],
                              ),
                            ))),
                  ],
                ),
              ),
              SizedBox(height: 7),
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
                          flex: 4,
                          child: Text(
                            "Sehir",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Fiyat",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "ID",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Düzenle - Sil",
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 180, 150)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
