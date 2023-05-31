import 'package:flutter/material.dart';
import 'package:flutter_database/db/earn.dart';
import 'package:isar/isar.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  late Isar isar;
  List<Earn> dbEarn = [];

  List<dynamic> earn = [
    {
      "id": 1,
      "title": "Belediye Bütçesi",
      "earnValue": 18000.0,
      "description": "Belediyeye Yıllık Verilen Bütçe",
    },
    {
      "id": 2,
      "title": "Ulaşım Gelirleri",
      "earnValue": 7000.0,
      "description": "Belediyeye bağlı toplu ulaşım araçlarından gelen gelir",
    },
    {
      "id": 3,
      "title": "Bagıs Gelirleri",
      "earnValue": 3000.0,
      "description": "Kisisel olarak yapılan bagısların gelirleri",
    },
    {
      "id": 4,
      "title": "Kiralanan Yerler",
      "earnValue": 2000.0,
      "description": "Belediyeye ait yerlerin gelirleri",
    },
    {
      "id": 5,
      "title": "Sosyal tesis",
      "earnValue": 8000.0,
      "description": "Belediye yemek alanlarının gelirleri",
    },
  ];

// Database veri ekleme fonksiyonu
  addEarn(String title, String description, double earnValue) async {
    Earn newEarn = Earn()
      ..description = description
      ..save = false
      ..earnValue = earnValue
      ..title = title;

    await isar.writeTxn(() async {
      var addedID = await isar.earns.put(newEarn);
      print(addedID);
      getAllEarn();
    });
  }

// Verileri güncelleme fonksiyonu
  editEarn(int id, String title, String description, double earnValue) async {
    Earn newEarn = Earn()
      ..description = description
      ..save = false
      ..earnValue = earnValue
      ..title = title;

    await isar.writeTxn(() async {
      var addedID = await isar.earns.put(newEarn);
      print(addedID);
      getAllEarn();
    });
  }

// Verileri silme fonksiyonu
  deleteEarn(int id) async {
    isar.writeTxn(() async {
      var result = await isar.earns.delete(id);
      if (result) {
        print('news removed');
        getAllEarn();
      } else {
        print('not removed.');
      }
    });
  }

  getFromServer() {
    for (int i = 0; i < earn.length; i++) {
      addEarn(earn[i]["title"], earn[i]["description"], earn[i]["earnValue"]);
    }
  }

  // Begeniye ekleme ve cıkarma
  switchSave(Earn earn) async {
    Earn saveEarn = earn;
    saveEarn..save = !saveEarn.save;
    isar.writeTxn(() async {
      await isar.earns.put(saveEarn);
      getAllEarn();
    });
  }

  // Verileri okuma
  getAllEarn() async {
    dbEarn = await isar.earns.where().findAll();
    setState(() {});
  }

  // favorileri gosterme
  getFavoriteProducts() async {
    dbEarn = await isar.earns.filter().saveEqualTo(true).findAll();
    setState(() {});
  }

  openConnection() async {
    isar = await Isar.open([EarnSchema]);
    getAllEarn();
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
        title: Text("Belediye Gelirlerinin Verileri"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getFromServer();
              },
              child: Text('Gelirleri görüntüle')),
          ElevatedButton(
              onPressed: () {
                getFavoriteProducts();
              },
              child: Text('Kayıtlı gelirleri goster')),
          ElevatedButton(
              onPressed: () async {
                dbEarn = await isar.earns.where().sortByEarnValue().findAll();
                setState(() {});
              },
              child: Text('Gelirleri azdan coga sırala ')),
          ElevatedButton(
              onPressed: () async {
                dbEarn =
                    await isar.earns.where().sortByEarnValueDesc().findAll();
                setState(() {});
              },
              child: Text('Gelirleri cokta aza  sırala ')),
          ElevatedButton(
              onPressed: () async {
                dbEarn = await isar.earns
                    .filter()
                    .earnValueBetween(5000, 7000,
                        includeLower: true, includeUpper: true)
                    .findAll();
                setState(() {});
              },
              child: Text('5000 ve 700 arasında olan gelirleri görüntüle')),
          ElevatedButton(
              onPressed: () async {
                dbEarn = await isar.earns
                    .filter()
                    .titleStartsWith("Bagıs", caseSensitive: true)
                    .findAll();
                setState(() {});
              },
              child:
                  Text('Kişisel olarak toplanan bağış gelirlerini görüntüle')),
          ElevatedButton(
              onPressed: () async {
                dbEarn = await isar.earns
                    .filter()
                    .titleContains("Ulaşım", caseSensitive: true)
                    .findAll();
                setState(() {});
              },
              child: Text('Ulaşımla ilgili gelirleri göster')),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: dbEarn
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
                              Text("${e.earnValue!}"),
                              SizedBox(
                                height: 15,
                              ),
                              Text(""),
                              ElevatedButton(
                                  onPressed: () {
                                    deleteEarn(e.id);
                                  },
                                  child: Icon(Icons.delete)),
                              ElevatedButton(
                                  onPressed: () {
                                    switchSave(e);
                                  },
                                  child: e.save
                                      ? Text('Geliri kayıttan çıkar')
                                      : Text('Geliri Kaydet')),
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
