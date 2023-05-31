import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../db/book.dart';
import '../utils/utils.dart';
import 'home_page.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {

  bool hasFavorites = books.any((e) => e.favorite == true);

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

  switchFavorite(Book book) async {
    book.favorite =! book.favorite!;
    await isar.writeTxn(() async {
      await isar.books.put(book);
    });
    books = await isar.books.where().findAll();
  }

  @override
  void initState() {
    super.initState();
    openConnection();
  }

  @override
  void dispose() {
    super.dispose();
    // closeConnection();
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
          title: Text("Favoriler"),
        ),
        body: hasFavorites ? SingleChildScrollView(
          child: Column(
            children: books.map((e) {
              return e.favorite == true ? Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(e.imageBook!, fit: BoxFit.cover)
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Icon(Icons.favorite_outlined, color: Colors.red, size: 32),
                        onTap: () async {
                          switchFavorite(e);
                          hasFavorites = books.any((e) => e.favorite == true);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )
              ) : SizedBox();
            }).toList(),
          ),
        ) : Center(
          child: Text("Favori listesi boş!", style: Theme.of(context).textTheme.titleLarge)
        )
      ),
    );
  }
}