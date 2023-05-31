import 'package:flutter/material.dart';
import 'package:flutter_database/db/costs.dart';
import 'package:flutter_database/db/news.dart';
import 'package:flutter_database/db/product.dart';
import 'package:isar/isar.dart';

class CostsScreen extends StatefulWidget {
  const CostsScreen({super.key});

  @override
  State<CostsScreen> createState() => _CostsScreenState();
}

class _CostsScreenState extends State<CostsScreen> {
  late Isar isar;
  List<News> posts = [];
  List<Cost> dbCost = [];

  List<dynamic> costs = [
    {
      "id": 1,
      "title": "Fen İşleri Müdürlüğü",
      "cost": 12000.0,
      "description": "Yol bakım ve düzeltme işleri harcamaları",
    },
    {
      "id": 2,
      "title": "İski A.ş",
      "cost": 7000.0,
      "description": "Su altyapısı ve bakım harcamaları",
    },
    {
      "id": 3,
      "title": "Ulaşım A.ş",
      "cost": 3000.0,
      "description": "Toplu tasıma araçları benzin ve calışan harcamaları",
    },
    {
      "id": 4,
      "title": "Bogaziçi Elektrik",
      "cost": 2000.0,
      "description": "Elektrik altyapısı ve bakım harcamaları",
    },
    {
      "id": 5,
      "title": "Sosyal Tesisler ve Cafeler",
      "cost": 8000.0,
      "description":
          "Belediyeye ait tesislerin calışanları ve cesitli giderleri",
    },
  ];

// Database veri ekleme fonksiyonu
  addCost(String title, String description, double cost) async {
    Cost newCost = Cost()
      ..description = description
      ..save = false
      ..cost = cost
      ..title = title;

    await isar.writeTxn(() async {
      var addedID = await isar.costs.put(newCost);
      print(addedID);
      getAllCost();
    });
  }

// Verileri güncelleme fonksiyonu
  editCost(int id, String title, String description, double cost) async {
    Cost newCost = Cost()
      ..description = description
      ..save = false
      ..cost = cost
      ..title = title;

    await isar.writeTxn(() async {
      var addedID = await isar.costs.put(newCost);
      print(addedID);
      getAllCost();
    });
  }

// Verileri silme fonksiyonu
  deleteCost(int id) async {
    isar.writeTxn(() async {
      var result = await isar.costs.delete(id);
      if (result) {
        print('news removed');
        getAllCost();
      } else {
        print('not removed.');
      }
    });
  }

  getFromServer() {
    for (int i = 0; i < costs.length; i++) {
      addCost(costs[i]["title"], costs[i]["description"], costs[i]["cost"]);
    }
  }

  // Begeniye ekleme ve cıkarma
  switchSave(Cost cost) async {
    Cost saveCost = cost;
    saveCost..save = !saveCost.save;
    isar.writeTxn(() async {
      await isar.costs.put(saveCost);
      getAllCost();
    });
  }

  // Verileri okuma
  getAllCost() async {
    dbCost = await isar.costs.where().findAll();
    setState(() {});
  }

  // favorileri gosterme
  getFavoriteProducts() async {
    dbCost = await isar.costs.filter().saveEqualTo(true).findAll();
    setState(() {});
  }

  openConnection() async {
    isar = await Isar.open([CostSchema]);
    getAllCost();
  }

  closeConnection() async {
    // Database baglanmadıgında uygulamanın çökmesini engelleme
    try {
      var result = await isar.close();
      if (result) {
        print('Successfuly');
      } else {
        print('Not Closed.');
      }
    } catch (e) {
      print('Error');
      print(e);
    }
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 14, 17, 73),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Belediye Harcama Verileri"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getFromServer();
              },
              child: Text('Harcamaları görüntüle')),
          ElevatedButton(
              onPressed: () {
                getFavoriteProducts();
              },
              child: Text('Kayıtlı harcamaları goster')),
          ElevatedButton(
              onPressed: () async {
                dbCost = await isar.costs
                    .filter()
                    .costBetween(2000, 5000,
                        includeUpper: true, includeLower: true)
                    .findAll();
                setState(() {});
              },
              child: Text('2000 ve 5000 arasında olan harcamaları göster')),
          ElevatedButton(
              onPressed: () async {
                dbCost = await isar.costs.where().sortByTitle().findAll();
                setState(() {});
              },
              child: Text('Harcamaları baslıga göre alfabetik  sırala ')),
          ElevatedButton(
              onPressed: () async {
                dbCost = await isar.costs
                    .filter()
                    .titleContains("Sosyal", caseSensitive: true)
                    .findAll();
                setState(() {});
              },
              child: Text('Sosyal tesislerle ilgili harcamaları görüntüle')),
          ElevatedButton(
              onPressed: () async {
                dbCost = await isar.costs
                    .filter()
                    .descriptionContains("bakım", caseSensitive: true)
                    .findAll();
                setState(() {});
              },
              child: Text('Bakım harcamalarını görüntüle')),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: dbCost
                    .map((e) => Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey, width: 2)),
                          child: Column(
                            children: [
                              Text("${e.id}"),
                              SizedBox(
                                height: 15,
                              ),
                              Text("${e.title!}"),
                              SizedBox(
                                height: 15,
                              ),
                              Text("${e.description!}"),
                              SizedBox(
                                height: 15,
                              ),
                              Text("${e.cost!}"),
                              SizedBox(
                                height: 15,
                              ),
                              Text(""),
                              ElevatedButton(
                                  onPressed: () {
                                    deleteCost(e.id);
                                  },
                                  child: Icon(Icons.delete)),
                              ElevatedButton(
                                  onPressed: () {
                                    switchSave(e);
                                  },
                                  child: e.save
                                      ? Text('Harcamayı kayıttan çıkar')
                                      : Text('Harcamayı Kaydet')),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
