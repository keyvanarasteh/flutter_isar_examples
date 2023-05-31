// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 14, 17, 73),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Belediye Gelir ve Gider Kontrol Uygulaması",
            style: TextStyle(fontSize: 19),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              //  spacing: 10,
              // runSpacing: 10,
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/tr/2/24/Ibb_amblem.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/cost');
                    },
                    child: Text('Gider Kontrol Ekranı')),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/earn');
                    },
                    child: Text('Gelir Kontrol Ekranı')),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/date');
                    },
                    child: Text('Tarih Ekranı')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/chart');
                    },
                    child: Text('Chart Ekranı')),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Created for flutter homework by Safa Akdeniz",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                /*
                Text("Ek Ekranlar"),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/information');
                    },
                    child: Text('Flutter Info')),
                Image.network(
                  'https://cdn.pixabay.com/photo/2012/05/07/18/57/blog-49006_1280.png',
                  height: 200,
                  width: 200,
                ),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/about');
                    },
                    child: Text('About')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/users');
                    },
                    child: Text('Users')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/ali');
                    },
                    child: Text('Wrong Route')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/contact');
                    },
                    child: Text('/contact')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/contact?page=urun');
                    },
                    child: Text('/contact?page=urun')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .push('/contact?page=hakkimizda&&onerici=safa');
                    },
                    child: Text('/contact?page=hakkimizda&&onerici=safa')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/contact?y=1&x=2&z=ali');
                    },
                    child: Text('/contact?y=1&x=2&z=ali')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/contact2');
                    },
                    child: Text('/contact2')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/contact2?page=urun');
                    },
                    child: Text('/contact2?page=urun')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .push('/contact2?page=hakkimizda&&onerici=safa');
                    },
                    child: Text('/contact2?page=hakkimizda&&onerici=safa')),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/contact2?y=1&x=2&z=ali');
                    },
                    child: Text('/contact2?y=1&x=2&z=ali')),
                    
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/news');
                    },
                    child: Text('Geek Blog')),
                SizedBox(
                  height: 30,
                ),
                Image.network(
                  'https://www.maxpixel.net/static/photo/1x/Office-Technology-Computer-Laptop-Business-5304694.png',
                  height: 100,
                  width: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).push('/products');
                    },
                    child: Text('Teknoloji Ürünleri')),
                    */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
