// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import '../db/product.dart';
import '../widgets/filled_text_field.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Isar isar;
  TextEditingController nameController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  bool addMode = true;
  String name = "";
  int order = 0;
  Id? updateid = null;

  List<Category> categories = [];

  addCategory() async {
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Kategori adi girmeniz gerekiyor'),
      ));
    } else {
      final newCategory = Category()
        ..categoryname = name
        ..order = order;
        DateTime.now();

      await isar.writeTxn(() async {
        await isar.categorys.put(newCategory);

        nameController = TextEditingController(text: "");
        orderController = TextEditingController(text: "");
        setState(() {});
      });
      getCategories();
    }
  }

  updateCategory(Category category, categoryId, ) async {
    final category = await isar.categorys.get(categoryId);
    if (category != null) {
      await isar.writeTxn(() async {
        category.categoryname = name;
        category.order = order;

        await isar.categorys.put(category);
      });
      getCategories();
    }
  }

  getCategories() async {
    categories = await isar.categorys.where().sortByOrder().findAll();
    setState(() {});
  }

  removeCategory(int categoryId) async {
    int productCount =
        await isar.products.filter().categoryEqualTo(categoryId).count();
    if (productCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Ürünu olan kategoriyi silemezsiniz.'),
      ));
      return;
    }
    await isar.writeTxn(() async {
      bool result = await isar.categorys.delete(categoryId);
      if (result) {
        getCategories();
        addMode = true;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Kategori silinemedi.'),
        ));
      }
    });
  }

  void _showAlertDialog(BuildContext context, int categoryId) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Onay'),
        content: const Text('Kategorini silmek istediğinizden emin misiniz?'),
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
              removeCategory(categoryId);
            },
            child: const Text('Evet'),
          ),
        ],
      ),
    );
  }

  List<Widget> categoriesWidgets() {
    if (categories.isEmpty) {
      return [
        Center(
            child: Text(
          'Kategori Bulunamadi.',
          style: TextStyle(color: Colors.white),
        ))
      ];
    } else {
      return categories
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
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            e.categoryname!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            e.order.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
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
                                    name = e.categoryname!;
                                    order = e.order;

                                    nameController = TextEditingController(
                                        text: e.categoryname!);
                                    orderController = TextEditingController(
                                        text: e.order.toString());
                                    updateid = e.id;
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

  openConnection() async {
    try {
      isar = await Isar.open([CategorySchema, ProductSchema , FlightpriceSchema]);
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
        backgroundColor: Color.fromARGB(255, 29, 32, 36),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 45,
                        ),
                        child: Center(
                          child: Text(
                            "Firmalar",
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
              ),
              SizedBox(height: 15),
              Text(
                'Firma Adı:',
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
                  hintText: 'Firma Adı',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 80, 80, 90)),
                  filled: true,
                  fillColor: Color.fromARGB(143, 45, 47, 57),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
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
                    if (value.isEmpty) {
                      order = 0;
                    } else {
                      order = int.parse(value);
                    }
                    setState(() {});
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Siralama Sayi olmasi gerekiyor.'),
                    ));
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
              SizedBox(height: 30),
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
                             if (addMode) {
                                addCategory();
                              } else {
                                updateCategory(Category(), updateid);
                                addMode = true;
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  Text(addMode ? 'Ekle' : 'Düzenle'),
                                ],
                              ),
                            ))),
                    SizedBox(width: 5.0),
                    !addMode
                        ? Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 45, 47, 57),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  addMode = true;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel),
                                      Text('Iptal'),
                                    ],
                                  ),
                                )))
                        : SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 18),
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
                          flex: 3,
                          child: Text(
                            "Firma",
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
                          flex: 3,
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
                children: categoriesWidgets(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
