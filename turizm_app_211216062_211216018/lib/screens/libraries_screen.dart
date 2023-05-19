// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LibScreen extends StatefulWidget {
  const LibScreen({super.key});

  @override
  State<LibScreen> createState() => _LibScreenState();
}

class _LibScreenState extends State<LibScreen> {
  DateTime? selectedDate;

  getToday() {
    selectedDate = DateTime.now();
    setState(() {});
  }

  getTomorrow() {
    selectedDate = DateTime.now();
    selectedDate = selectedDate!.add(Duration(days: 1));
    setState(() {});
  }

  getNextDay() {
    if (selectedDate == null) {
      selectedDate = DateTime.now();
    } else {
      selectedDate = selectedDate!.add(Duration(days: 1));
    }
    setState(() {});
  }

  getNextMonth() {
    selectedDate = DateTime.now();
    selectedDate = selectedDate!.add(Duration(days: 30));
    setState(() {});
  }

  showDate() {
    if (selectedDate != null) {
      return Text(selectedDate!.toString(),
          style: TextStyle(color: Colors.white));
    } else {
      return Text("Tarih yok", style: TextStyle(color: Colors.white));
    }
  }

  showFormatedDate() {
    if (selectedDate != null) {
      var tarihim =
          DateFormat("yyyy EEEE E MMM MMMM k K m s").format(selectedDate!);
      return Text(tarihim, style: TextStyle(color: Colors.white));
    } else {
      return Text("Tarih yok", style: TextStyle(color: Colors.white));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 29, 32, 36),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => GoRouter.of(context).pop('/home'),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white24,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Text(
                          'Date Time Düzenlenicek Ekran ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(onPressed: () => getToday(), child: Text("Bugün")),
              SizedBox(
                height: 7,
              ),
              ElevatedButton(
                  onPressed: () => getTomorrow(), child: Text("Yarin")),
              SizedBox(
                height: 7,
              ),
              ElevatedButton(
                  onPressed: () => getNextMonth(), child: Text("30 gün sonra")),
              SizedBox(
                height: 7,
              ),
              ElevatedButton(
                  onPressed: () => getNextDay(), child: Text("Sonra ki gün")),
              SizedBox(
                height: 7,
              ),
              showDate(),
              SizedBox(
                height: 7,
              ),
              showFormatedDate(),
            ],
          ),
        ),
      ),
    );
  }
}
