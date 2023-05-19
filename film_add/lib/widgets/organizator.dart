import 'package:film_add/screen/add_cost.dart';
import 'package:film_add/screen/add_money.dart';
import 'package:film_add/screen/charts.dart';
import 'package:film_add/screen/linecharts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class organizator extends StatefulWidget {
  final String? username;
  final String? name;
  const organizator({super.key, this.username, this.name});

  @override
  State<organizator> createState() => organizatorState();
}

class organizatorState extends State<organizator> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: secenek(screenWidth),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: secenek2(screenWidth)),
            ],
          ),
        ));
  }

  Row secenek(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          width: screenWidth / 2.8,
          child: Center(
              child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return addincome(
                    username: widget.username,
                    name: widget.name,
                  );
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(200, 220, 244, 1)),
                  child: Icon(Icons.attach_money_outlined),
                ),
                Text("Gelir Ekle")
              ],
            ),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Color.fromARGB(255, 247, 247, 247),
          ),
        ),
        Container(
          height: 80,
          width: screenWidth / 2.8,
          child: Center(
              child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return addCost(
                    username: widget.username,
                    name: widget.name,
                  );
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(200, 220, 244, 1)),
                  child: Icon(Icons.money_off_csred_outlined),
                ),
                Text("Gider Ekle")
              ],
            ),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Color.fromARGB(255, 247, 247, 247),
          ),
        ),
      ],
    );
  }

  Row secenek2(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          width: screenWidth / 2.8,
          child: Center(
              child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return charts(
                    name: widget.name,
                    username: widget.username,
                  );
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(200, 220, 244, 1)),
                  child: Icon(Icons.add_chart_outlined),
                ),
                Flexible(child: Text("Gelir-Gider Tablosu"))
              ],
            ),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Color.fromARGB(255, 247, 247, 247),
          ),
        ),
        Container(
          height: 80,
          width: screenWidth / 2.8,
          child: Center(
              child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return linecharts(
                    username: widget.username,
                    name: widget.name,
                  );
                },
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(200, 220, 244, 1)),
                  child: Icon(Icons.money_off_csred_outlined),
                ),
                Flexible(
                  child: Text(
                    "Aylık Gelir Gider Gösterimi",
                  ),
                ),
              ],
            ),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Color.fromARGB(255, 247, 247, 247),
          ),
        ),
      ],
    );
  }
}
