import 'package:flutter/material.dart';
import 'package:flutter_database/db/news.dart';
import 'package:flutter_database/db/product.dart';
import 'package:isar/isar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Isar isar;
  List<News> posts = [];
  List<Product> dbProduct = [];

  List<dynamic> products = [
    {
      "id": 1,
      "name": "Apple Macbook Pro 2022",
      "price": 56000.0,
      "image":
          "https://cdn.pixabay.com/photo/2020/06/29/07/19/macbook-pro-5351689_1280.png",
      "category": "Laptop",
    },
    {
      "id": 2,
      "name": "Lenovo Legıon Laptop",
      "price": 40000.0,
      "image":
          "https://www.trustedreviews.com/wp-content/uploads/sites/54/2022/01/Lenovo-Yoga-6_Gen_7_Modes.png",
      "category": "Laptop",
    },
    {
      "id": 3,
      "name": "Samsung A5",
      "price": 30000.0,
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/5/5c/Samsung_Galaxy_Z_Flip_5G.png",
      "category": "Mobile",
    },
    {
      "id": 4,
      "name": "Lenovo D27HD",
      "price": 20000.0,
      "image":
          "https://www.maxpixel.net/static/photo/1x/Large-Tv-Flat-Screen-Tv-Modern-Tv-Television-1722834.png",
      "category": "Monitör",
    },
    {
      "id": 5,
      "name": "Anker Q10",
      "price": 5000.0,
      "image":
          "https://www.maxpixel.net/static/photo/1x/Headphones-Sennheiser-Studio-Dj-Headphone-Audio-5994443.png",
      "category": "Headphone",
    },
  ];

// Database veri ekleme fonksiyonu
  addProduct(String title, String category, String description,
      String imagePath, double price) async {
    Product newProduct = Product()
      ..category = category
      ..description = description
      ..favorite = false
      ..imgUrl = imagePath
      ..price = price
      ..tags = ["tag1", "tag2", "tag3"]
      ..title = title;

    await isar.writeTxn(() async {
      var addedID = await isar.products.put(newProduct);
      print(addedID);
      getAllProducts();
    });
  }

// Verileri güncelleme fonksiyonu
  editProduct(int id, String title, String category, String description,
      String imagePath, double price) async {
    Product newProduct = Product()
      ..id = id
      ..category = category
      ..description = description
      ..favorite = false
      ..imgUrl = imagePath
      ..price = price
      ..tags = ["tag1", "tag2", "tag3"]
      ..title = title;

    await isar.writeTxn(() async {
      var addedID = await isar.products.put(newProduct);
      print(addedID);
      getAllProducts();
    });
  }

// Verileri silme fonksiyonu
  deleteProduct(int id) async {
    isar.writeTxn(() async {
      var result = await isar.products.delete(id);
      if (result) {
        print('news removed');
        getAllProducts();
      } else {
        print('not removed.');
      }
    });
  }

  getFromServer() {
    for (int i = 0; i < products.length; i++) {
      addProduct(products[i]["name"], products[i]["category"], "",
          products[i]["image"], products[i]["price"]);
    }
  }

  // Begeniye ekleme ve cıkarma
  switchFavorite(Product product) async {
    Product upsatedProduct = product;
    upsatedProduct.favorite = !upsatedProduct.favorite;
    isar.writeTxn(() async {
      await isar.products.put(upsatedProduct);
      getAllProducts();
    });
  }

  // Verileri okuma
  getAllProducts() async {
    dbProduct = await isar.products.where().findAll();
    setState(() {});
  }

  // favorileri gosterme
  getFavoriteProducts() async {
    dbProduct = await isar.products.filter().favoriteEqualTo(true).findAll();
    setState(() {});
  }

  openConnection() async {
    isar = await Isar.open([ProductSchema]);
    getAllProducts();
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
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getFromServer();
              },
              child: Text('Ürünleri görüntüle')),
          ElevatedButton(
              onPressed: () {
                getFavoriteProducts();
              },
              child: Text('Favorileri goster')),
          ElevatedButton(
              onPressed: () async {
                dbProduct = await isar.products.where().sortByPrice().findAll();
                setState(() {});
              },
              child: Text('Ucuzdan pahalıya Sırala ')),
          ElevatedButton(
              onPressed: () async {
                dbProduct =
                    await isar.products.where().sortByPriceDesc().findAll();
                setState(() {});
              },
              child: Text('Pahalıdan ucuza Sırala ')),
          ElevatedButton(
              onPressed: () async {
                dbProduct = await isar.products
                    .filter()
                    .priceLessThan(20000, include: true)
                    .findAll();
                setState(() {});
              },
              child: Text('20 altını goster')),
          ElevatedButton(
              onPressed: () async {
                dbProduct = await isar.products
                    .filter()
                    .priceGreaterThan(40000, include: true)
                    .findAll();
                setState(() {});
              },
              child: Text('40 ustunu goster')),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: dbProduct
                    .map((e) => Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey, width: 2)),
                          child: Column(
                            children: [
                              Image.network(e.imgUrl!),
                              Text("${e.id} ${e.title!}"),
                              Text("${e.category!}"),
                              Text("${e.price!}"),
                              Text(""),
                              ElevatedButton(
                                  onPressed: () {
                                    deleteProduct(e.id);
                                  },
                                  child: Icon(Icons.delete)),
                              ElevatedButton(
                                  onPressed: () {
                                    //editProduct(e["id"], '${e["name"]}-', '-', "");
                                  },
                                  child: Icon(Icons.edit)),
                              ElevatedButton(
                                  onPressed: () {
                                    switchFavorite(e);
                                  },
                                  child: e.favorite
                                      ? Text('Dislike')
                                      : Text('Begeniye Ekle')),
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
