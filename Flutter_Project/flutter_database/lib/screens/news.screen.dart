import 'package:flutter/material.dart';
import 'package:flutter_database/db/news.dart';
import 'package:isar/isar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Isar isar;
  List<News> posts = [];

// Database veri ekleme fonksiyonu
  addPost(String title, String content, String imagePath) async {
    News newNews = News()
      ..title = title
      ..content = content
      ..imagePath = imagePath;

    await isar.writeTxn(() async {
      var addedID = await isar.news.put(newNews);
      print(addedID);
    });
  }

// Verileri güncelleme fonksiyonu
  editPost(int id, String title, String content, String imagePath) async {
    News newNews = News()
      ..id = id
      ..title = title
      ..content = content
      ..imagePath = imagePath;

    await isar.writeTxn(() async {
      var addedID = await isar.news.put(newNews);
      print(addedID);
      getAllNews();
    });
  }

// Verileri silme fonksiyonu
  deletePost(int id) async {
    isar.writeTxn(() async {
      var result = await isar.news.delete(id);
      if (result) {
        print('news removed');
        getAllNews();
      } else {
        print('not removed.');
      }
    });
  }

// Verileri okuma
  getAllNews() async {
    posts = await isar.news.where().findAll();
    setState(() {});
  }

  openConnection() async {
    isar = await Isar.open([NewsSchema]);
    getAllNews();
  }

  closeConnection() async {
    // Database baglanmadıiında uygulamanın çökmesini engelleme
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
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                for (var i = 0; i < 10; i++) {
                  addPost('Haber $i', 'Haber Metni $i , devami', 'gorsel$i');
                }

                getAllNews();
              },
              child: Text('Add New Post')),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: posts
                    .map((e) => Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey, width: 2)),
                          child: Column(
                            children: [
                              Text("${e.id} ${e.title!}"),
                              Text(e.content!),
                              ElevatedButton(
                                  onPressed: () {
                                    deletePost(e.id);
                                  },
                                  child: Icon(Icons.delete)),
                              ElevatedButton(
                                  onPressed: () {
                                    editPost(e.id, '${e.title}-',
                                        '${e.content}-', "");
                                  },
                                  child: Icon(Icons.edit)),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.heart_broken)),
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
