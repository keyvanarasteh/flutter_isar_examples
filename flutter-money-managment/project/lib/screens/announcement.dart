// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AnnouncementGeneral extends StatelessWidget {
  const AnnouncementGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DUYURULAR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "İLERİ Kİ PROJELERDE YENİ GÜNCELLEME İLE GELECEK",
                  style: TextStyle(fontSize: 22),
                ),
              ))
        ],
      ),
    );
  }
}
