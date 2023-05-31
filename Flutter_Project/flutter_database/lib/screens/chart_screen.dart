import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Text(
                "Hocam tarih ve chart  için kullandığımız paketleri yüklediğimde hata alıyorum 4,5 saat uğraştım ama çözemedim. İnternette araştırdım ve yaptım söyleneni ama işe yaramadı. Size sorucaktım ama haftasonu ve az kaldığı için dönmeniz geç olur diye düşündüm. Haftaiçide diğer okul sınavları oldğu için bakamadım.")),
      ),
    );
  }
}
