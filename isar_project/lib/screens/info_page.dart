import 'dart:async';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/db/book.dart';
import 'package:isar_project/screens/home_page.dart';

import '../utils/utils.dart';


class InfoPage extends StatefulWidget {
  int id;
  bool writer;
  InfoPage({
    Key? key,
    required this.id,
    required this.writer,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}
class _InfoPageState extends State<InfoPage> {

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

  editPost(int id, String name, String writer, String subject, String imageBook, String imageWriter, double price, int stok) async {
    Book newBook = Book()
      ..id = id
      ..name = name
      ..writer = writer
      ..subject = subject
      ..imageBook = imageBook
      ..imageWriter = imageWriter
      ..price = price
      ..stok = stok;
    await isar.writeTxn(() async {
      var addedId = isar.books.put(newBook);
      print(addedId);
    });
    books = await isar.books.where().findAll();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Düzenleme işlemi başarılı..")));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  deleteBook(int id) async {
    isar.writeTxn(() async {
      try {
        var result = await isar.books.delete(id);
        if (result) {
          print("silindi");
          books = await isar.books.where().findAll();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Silme işlemi başarılı..")));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        }
        else {
          print("hatalı silinme");
        }
      } catch (e) {
        print("hataaaaaaaaaa $e");
      }
    });
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text("Düzenlensin mi?", textAlign: TextAlign.center),
              content: Text("Bu öğe otomatik olarak değiştirilecektir. Emin misiniz?"),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Vazgeç"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Düzenle"),
                  onPressed: () async {
                    Navigator.pop(context);
                    Timer(Duration(seconds: 1), () {
                      editPost(
                        books[widget.id].id,
                        "Simyacı", 
                        "Paulo Coelho", 
                        '''Simyacı, Brezilyalı eski şarkı sözü yazarı Paulo Coelho'nun, yayınlandığı 1988 yılından bu yana dünyayı birbirine katan, eleştirmenler tarafından bir `fenomen' olarak değerlendirilen üçüncü romanı. Simyacı, altı yılda kırk iki ülkede yedi milyondan fazla sattı. Bu, Gabriel Garcia Marquez'den bu yana görülmemiş bir olay. Yüreğinde, çocukluğunu yitirmemiş olan okurlar için bir `klasik' kimliği kazanan Simyacı'yı Saint-Exupery'nin Küçük Prens'i ve Richard Bach'ın Martı Jonathan Livingston'u ile karşılaştıranlar var (Publishers Weekly). Simyacı, İspanya'dan kalkıp Mısır Piramitlerinin eteklerinde hazinesini aramaya giden Endülüslü çoban Santiago'nun masalsı yaşamının felsefi öyküsü. Sanki bir `nasihatnâme': `Yazgına nasıl egemen olacaksın, mutluluğunu nasıl kuracaksın?' sorularına yanıt arayan bir hayat ve ahlak kılavuzu. Mistik bir peri masalına benzeyen romanın altı yılda, yedi milyondan fazla okur bulmasının gizi, kuşkusuz, onun bu kılavuzluk niteliğinden kaynaklanıyor. Simyacı'yı okumak, herkes daha uykudayken, güneşin doğuşunu seyretmek için şafak vakti uyanmaya benziyor.''',
                        "https://pz0fpvezntt4.merlincdn.net/productimages/118628/big/9789750726439_front_cover_.jpg",
                        "https://pz0fpvezntt4.merlincdn.net/Skins/shared/images/yazar/desktop/Paulo%20Coelho_3.png",
                        40, 
                        1,
                      );
                    });
                  },
                ),
              ],
            );
          },
        );
        break;
      case 1:
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text("Silinsin mi?", textAlign: TextAlign.center),
              content: Text("Bu öğe kalıcı olarak silinecektir. Emin misiniz?"),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Vazgeç"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Sil"),
                  onPressed: () async {
                    if (books.length == 1) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Son kalan kitap silinemez")));
                    }
                    else {
                      Navigator.pop(context);
                      Timer(Duration(seconds: 1), () {
                        deleteBook(books[widget.id].id);
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
        break;
    }
  }

  Timer? priceTimer;
  bool color = true;

  @override
  void initState() {
    super.initState();
    openConnection();
    priceTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        color = ! color;        
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // closeConnection();
    priceTimer!.cancel();
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(350),
          child: AppBar(
            actions: [
              widget.writer ? SizedBox()
              :
              PopupMenuButton<int>(
                onSelected: (item) => handleClick(item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(value: 0, child: Text('Düzenle')),
                  PopupMenuItem<int>(value: 1, child: Text('Sil')),
                ],
              )
            ],
            flexibleSpace: widget.writer ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "writer ${widget.id}",
                    child: ClipOval(
                            child: Image.network(
                              books[widget.id].imageWriter!,
                              fit: BoxFit.fill,
                              width: 200,
                              height: 200,
                            ),
                          ),
                  ),
                  SizedBox(height: 10),
                  Text(books[widget.id].writer!, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            )
            :
            SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "image ${widget.id}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            books[widget.id].imageBook!,
                            height: 200,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(books[widget.id].name!, style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 5),
                      Text("- ${books[widget.id].writer!} -", style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: color ? Colors.orange : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text("${books[widget.id].price!.toStringAsFixed(2)} ₺", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: color ? Colors.white : Colors.orange,
                            )),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Text("${(books[widget.id].price! + 3).toStringAsFixed(2)} ₺", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.red,
                                        )),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: widget.writer ? 
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: books.map((e) {
                return e.writer == books[widget.id].writer ? Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        width: 120,
                        height: 180,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(e.imageBook!, fit: BoxFit.fill),
                      )
                : SizedBox();
              }).toList(),
            ),
        )
        :
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("İçerik", style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 10),
                      Text(books[widget.id].subject!, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromHeight(50),
                          backgroundColor: Colors.white12,
                        ),
                        child: books[widget.id].favorite! ? Icon(Icons.favorite_outlined, color: Colors.red[900], size: 32) : Icon(Icons.favorite_border_outlined, color: Colors.red[900], size: 32),
                        onPressed: () async {
                          switchFavorite(books[widget.id]);
                          books = await isar.books.where().findAll();
                          setState(() {
                            
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromHeight(50),
                          backgroundColor: Colors.red[900],
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                        child: Text("Sepete Ekle"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } 
}