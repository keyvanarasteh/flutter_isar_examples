// ignore_for_file: prefer_const_constructors

import 'package:dashboard_app/widgets/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Internet().checkInternetCon();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/banner3.jpg',
                  fit: BoxFit.cover,
                  height: 160,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Divider(),
                    Row(
                      children: [
                        CustomButton(
                          text: 'Günlük Rapor',
                          imagePath: 'assets/images/kasa.png',
                          onTap: () => GoRouter.of(context).push('/order'),
                        ),
                        SizedBox(width: 15),
                        CustomButton(
                          text: 'Satışlar',
                          imagePath: 'assets/images/takvim.png',
                          onTap: () => GoRouter.of(context).push('/report'),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        CustomButton(
                          text: 'Fiyatlandırma',
                          imagePath: 'assets/images/check.png',
                          onTap: () => GoRouter.of(context).push('/products'),
                        ),
                        SizedBox(width: 15),
                        CustomButton(
                          text: 'Grafik',
                          imagePath: 'assets/images/rapor.png',
                          onTap: () => GoRouter.of(context).push('/chart'),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        CustomButton(
                          text: 'Bağlantı Test',
                          imagePath: 'assets/images/wifi.png',
                          onTap: () => GoRouter.of(context).push('/test'),
                        ),
                        SizedBox(width: 15),
                        CustomButton(
                          text: 'Duyurular',
                          imagePath: 'assets/images/an.png',
                          onTap: () => GoRouter.of(context).push('/duyuru'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
