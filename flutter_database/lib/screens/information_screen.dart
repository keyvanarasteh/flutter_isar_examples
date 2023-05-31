import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
              "Hocam staj ve diğer okul yoğun oldugu için  arayüz olarak cok detaylı yapamadım. Tek başıma yaptıgım için biraz fazla oldu. Temel olarak 2 harcamalar ve gelirler toblosu olusturdum.Bunları filtreliyebilecek ve kayıt edebilecek uygulama yaptım")),
    );
  }
}
