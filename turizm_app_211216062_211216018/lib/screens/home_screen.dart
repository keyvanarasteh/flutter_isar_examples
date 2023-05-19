import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:market_app/product/product1.dart';
import 'package:market_app/product/product2.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:market_app/screens/categories_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

  @override
  Widget build(BuildContext context) {
    var AntDesign;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: CustomNavigationBar(
            iconSize: 30.0,
            selectedColor: Color.fromARGB(255, 240, 180, 150),
            strokeColor: Color.fromARGB(255, 240, 180, 150),
            unSelectedColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 45, 47, 57),
            borderRadius: Radius.circular(20.0),
            items: [
              CustomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            isFloating: true,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 29, 32, 36),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.white,
                    ),
                    Text(
                      "Istanbul",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Color.fromARGB(255, 80, 80, 90),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 80, 80, 90)),
                  filled: true,
                  fillColor: Color.fromARGB(143, 45, 47, 57),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "İşlemler",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/categories'),
                          child: Transitions(
                            iconn: Icon(
                              Icons.airlines,
                              size: 30,
                              color: Color.fromARGB(255, 240, 180, 150),
                            ),
                            text: "Firmalar",
                          ),
                        ),
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/product'),
                          child: Transitions(
                            iconn: Icon(
                              Icons.airplane_ticket,
                              size: 30,
                              color: Color.fromARGB(255, 240, 180, 150),
                            ),
                            text: "Biletler",
                          ),
                        ),
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/libraries'),
                          child: Transitions(
                            iconn: Icon(
                              Icons.schedule,
                              size: 30,
                              color: Color.fromARGB(255, 240, 180, 150),
                            ),
                            text: "Libraries",
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              GoRouter.of(context).push('/rangepicker'),
                          child: Transitions(
                            iconn: Icon(
                              Icons.calendar_month,
                              size: 30,
                              color: Color.fromARGB(255, 240, 180, 150),
                            ),
                            text: "Range",
                          ),
                        ),
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/Chart'),
                          child: Transitions(
                            iconn: Icon(
                              Icons.pie_chart,
                              size: 30,
                              color: Color.fromARGB(255, 240, 180, 150),
                            ),
                            text: ".",
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              GoRouter.of(context).push('/information'),
                          child: Transitions(
                            iconn: Icon(
                              Icons.perm_device_information,
                              size: 30,
                              color: Color.fromARGB(255, 240, 180, 150),
                            ),
                            text: "information",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Sehirler",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () => GoRouter.of(context).push('/list'),
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Color.fromARGB(255, 240, 180, 150),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => GoRouter.of(context).push('/chart'),
                        child: Favorite(
                          image: "assets/images/947089.jpg",
                          text: "Tokyo",
                        ),
                      ),
                      Favorite(
                        image: "assets/images/New.jpg",
                        text: "New York",
                      ),
                      Favorite(
                        image: "assets/images/Ist.jpg",
                        text: "Istanbul",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
