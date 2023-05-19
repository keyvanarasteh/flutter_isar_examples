import 'package:film_add/db/cost.dart';
import 'package:film_add/db/income.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class balance extends StatefulWidget {
  final String? username;
  const balance({super.key, this.username});

  @override
  State<balance> createState() => _balanceState();
}

class _balanceState extends State<balance> {
  late Isar isar;
  num bakiye = 0;
  num giderler = 0;
  num gelirler = 0;
  gelir() async {
    gelirler = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in ggelir) {
      gelirler += i.draw!;
    }

    setState(() {});
  }

  gider() async {
    giderler = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in ggider) {
      giderler += i.outgo!;
    }

    setState(() {});
  }

  netBakiye() async {
    gelirler = 0;
    final ggelir = await isar.incomes
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in ggelir) {
      gelirler += i.draw!;
    }
    giderler = 0;
    final ggider = await isar.costs
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findAll();
    for (var i in ggider) {
      giderler += i.outgo!;
    }
    bakiye = gelirler - giderler;
    setState(() {});
  }

  @override
  void initState() {
    isar = Provider.of<Isar>(context, listen: false);
    super.initState();
    netBakiye();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Bakiye",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "$bakiye ₺",
                style: TextStyle(
                    fontSize: 74,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
