import 'dart:math';

import 'package:film_add/db/cost.dart';
import 'package:film_add/db/income.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class money extends StatefulWidget {
  final String? username;
  const money({super.key, this.username});

  @override
  State<money> createState() => _moneyState();
}

class _moneyState extends State<money> {
  List<Income> incomeList = [];
  double? money = 0;
  double? eksi = 0;
  late Isar isar;
  gelir() async {
    final gelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in gelir) {
      money = i.draw;
    }
    setState(() {});
  }

  gider() async {
    final gelir = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in gelir) {
      eksi = i.outgo;
    }
    setState(() {});
  }

  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      gelir();
      gider();
    });
    isar = Provider.of<Isar>(context, listen: false);
    // openConnetction();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: screenHeight / 5,
          width: screenWidth / 1.4,
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        width: (screenWidth / 1.4) / 1.4,
                        height: (screenHeight / 5) / 4,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Gelen Para",
                                style: TextStyle(color: Colors.green)),
                            Text("$money",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                          ],
                        )),
                      )
                    ]),
                    Padding(padding: EdgeInsets.all(8)),
                    Padding(padding: EdgeInsets.all(8)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        width: (screenWidth / 1.4) / 1.4,
                        height: (screenHeight / 5) / 4,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Giden Para",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0))),
                            Text(
                              "$eksi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        )),
                      )
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push('/home');
                      },
                      child: Text(
                        "Detaylı Görünüm şu an çalışmıyor",
                        style: TextStyle(color: Color(0xff058cc0)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
