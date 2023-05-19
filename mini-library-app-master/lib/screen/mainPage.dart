import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/screen/listBook.dart';
import 'package:databaseodev/screen/oduncKitap.dart';
import 'package:databaseodev/screen/person.dart';
import 'package:databaseodev/screen/secondpage.dart';
import 'package:databaseodev/widget/animatedBtn.dart';
import 'package:databaseodev/widget/snackDesign.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

import '../class/padding.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  int myIndex = 0;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  String sonuclar = "";
  List<Widget> widgetList = [
    SecondPage(),
    ListBook(),
    OduncAlan(),
    OduncKitap()
  ];
  bool _press = false;

  // bilgileriAl() async {
  //   final result = await (Connectivity().checkConnectivity());
  //   if (result == ConnectivityResult.mobile) {
  //     sonuclar = "Mobile";
  //   } else if (result == ConnectivityResult.wifi) {
  //     sonuclar = "WIFI";
  //   } else if (result == ConnectivityResult.ethernet) {
  //     sonuclar = "ETHERNET İLE BAĞLISIINZ";
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        this.result = result;
      });
    });
    super.initState();
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    internetSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "bg-images/lib.png",
                ),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      width: width * 0.7,
                      height: height * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: appColors.white.withOpacity(0.2),
                        ),
                        color: appColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: MyPadding.all,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "MİNİ KÜTÜPHANE UYGULAMASI",
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 24, color: appColors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                AnimatedBtn(
                                    onPressed: () {
                                      context.push('/secondPage');
                                    },
                                    child: Text(
                                      "Kitap Ekle ",
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 18,
                                          color: appColors.textColor),
                                    )),
                                AnimatedBtn(
                                    onPressed: () {
                                      context.push('/listBook');
                                    },
                                    child: Text(
                                      "Kitaplar",
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 18,
                                          color: appColors.textColor),
                                    )),
                                AnimatedBtn(
                                    onPressed: () {
                                      context.push('/oduncKitap');
                                    },
                                    child: Text(
                                      "Ödünç Kitap Al",
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 18,
                                          color: appColors.textColor),
                                    )),
                                AnimatedBtn(
                                    onPressed: () {
                                      context.push('/oduncAlan');
                                    },
                                    child: Text(
                                      "Ödünç Alanlar",
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 18,
                                          color: appColors.textColor),
                                    )),
                                AnimatedBtn(
                                    onPressed: () {
                                      context.push('/chartScreen');
                                    },
                                    child: Text(
                                      "GRAFIK",
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 18,
                                          color: appColors.textColor),
                                    )),
                                AnimatedBtn(
                                  onPressed: () async {
                                    result = await Connectivity()
                                        .checkConnectivity();
                                    hasInternet =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    final text = hasInternet
                                        ? "Internet"
                                        : "No Internet";
                                    if (result == ConnectivityResult.mobile) {
                                      showSimpleNotification(
                                          background: appColors.transparent,
                                          snackDesign(
                                              text1: "$text : Mobile Network",
                                              text2: "",
                                              colorSnack: appColors.snackGreen,
                                              image: Image.asset(
                                                  "images/connection32.png"),
                                              image2: Image.asset(
                                                  "images/connection32.png")));
                                    } else if (result ==
                                        ConnectivityResult.wifi) {
                                      showSimpleNotification(
                                          background: appColors.transparent,
                                          snackDesign(
                                              text1: "$text : Wifi Network",
                                              text2: "",
                                              colorSnack: appColors.snackGreen,
                                              image: Image.asset(
                                                  "images/connection32.png"),
                                              image2: Image.asset(
                                                  "images/connection32.png")));
                                    } else if (result ==
                                        ConnectivityResult.ethernet) {
                                      showSimpleNotification(
                                        background: appColors.transparent,
                                        snackDesign(
                                            text1: "$text :  Ethernet",
                                            text2: "",
                                            colorSnack: appColors.snackGreen,
                                            image: Image.asset(
                                                "images/connection32.png"),
                                            image2: Image.asset(
                                                "images/signal.png")),
                                      );
                                    } else {
                                      showSimpleNotification(
                                        background: appColors.transparent,
                                        snackDesign(
                                            text1: "$text",
                                            text2: "",
                                            colorSnack: appColors.snackRed,
                                            image: Image.asset(
                                                "images/disconnect.png"),
                                            image2: Image.asset(
                                                "images/disconnect2.png")),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Bağlantını Kontrol Et",
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 18,
                                        color: appColors.textColor),
                                  ),
                                ),
                                AnimatedBtn(
                                    onPressed: () {
                                      exit(0);
                                    },
                                    child: Text(
                                      "Çıkış",
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 18,
                                          color: appColors.textColor),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   showSelectedLabels: false,
          //   selectedItemColor: Color.fromARGB(255, 69, 127, 158),
          //   unselectedItemColor: Colors.black45,
          //   onTap: (index) {
          //     setState(() {
          //       myIndex = index;
          //     });
          //   },
          //   currentIndex: myIndex,
          //   items: [
          //     BottomNavigationBarItem(icon: Icon(Icons.library_add), label: ''),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.list_alt_rounded), label: ''),
          //     BottomNavigationBarItem(icon: Icon(Icons.info_outlined), label: ''),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.my_library_books_outlined), label: ''),
          //   ],
          // ),
        ),
      ),
    );
  }
}
