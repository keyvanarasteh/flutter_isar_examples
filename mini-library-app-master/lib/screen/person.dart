import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:databaseodev/database/person.dart';
import 'package:databaseodev/widget/appBar.dart';
import 'package:databaseodev/widget/snackDesign.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class OduncAlan extends StatefulWidget {
  const OduncAlan({super.key});

  @override
  State<OduncAlan> createState() => _OduncAlanState();
}

class _OduncAlanState extends State<OduncAlan> {
  late Isar isar;

  List<Person> personsList = [];
  getUsers() async {
    final person = await isar.persons.where().findAll();
    setState(() {
      personsList = person;
    });
  }

  @override
  void initState() {
    print("ekran calisti");
    // openConnection();

    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
    getUsers();
  }

  @override
  void dispose() {
    print("ekran kapandi");
    // closeConnection();
    super.dispose();
  }

  deletePerson(int id) async {
    await isar.writeTxn(() async {
      bool result = await isar.persons.delete(id);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: snackDesign(
              text1: "Dikkat ! ",
              text2: "Kişi Bilgileri Kaldırılmıştır ! ",
              colorSnack: appColors.snackRed,
              image: Image.asset("images/danger.png"),
              image2: Image.asset("images/paint-splash (2).png"),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: appColors.transparent,
            elevation: 0,
          ),
        );
        getUsers();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: snackDesign(
              text1: "Kişi Bulunamadı ",
              text2: "",
              colorSnack: appColors.snackRed,
              image: Image.asset("images/danger.png"),
              image2: Image.asset("images/paint-splash (2).png"),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: appColors.transparent,
            elevation: 0,
          ),
        );
      }
    });
  }

  void showAlert(QuickAlertType quickAlertType, int Index) {
    QuickAlert.show(
        context: context,
        type: quickAlertType,
        borderRadius: BorderSide.strokeAlignOutside,
        onConfirmBtnTap: () {
          deletePerson(Index);
          Timer(Duration(seconds: 1), () {
            Navigator.of(context, rootNavigator: true)
                .pop(); // QuickAlert'ı kapatmak için kullanılır
          });
        });
  }

  final double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(path: '/mainPage'),
        body: personsList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                        "Kişi Listeniz Boş Lütfen Kişi Bilgileri Ekleyiniz !"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedButton(
                    width: width * 0.5,
                    color: appColors.btn,
                    text: "Kişi Ekleyiniz ! ",
                    pressEvent: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Kişi Ekleme Ekranı Açılsın mı ?",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            GoRouter.of(context).pushNamed("/oduncKitap");
                          }).show();
                    },
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: personsList.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: MyPadding.all,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: appColors.white,
                                    borderRadius:
                                        BorderRadius.circular(_borderRadius),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Image.asset(
                                          'images/suspect.png',
                                          height: 64,
                                          width: 64,
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Ad Soyad",
                                              style: TextStyle(
                                                  color: appColors.grey),
                                            ),
                                            Text(
                                              personsList[index]
                                                      .name
                                                      .toString() +
                                                  " " +
                                                  personsList[index]
                                                      .surName
                                                      .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              "Telefon",
                                              style: TextStyle(
                                                color: appColors.grey,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              personsList[index]
                                                  .phone
                                                  .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              "Teslim Alınan Tarih",
                                              style: TextStyle(
                                                color: appColors.grey,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              personsList[index]
                                                  .date
                                                  .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "T.C.",
                                              style: TextStyle(
                                                color: appColors.grey,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              personsList[index].tc.toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              "Kitap İsmi",
                                              style: TextStyle(
                                                color: appColors.grey,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              personsList[index]
                                                  .bookName
                                                  .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Image.asset(
                                                "images/fingerprint.png")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 20,
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            showAlert(QuickAlertType.confirm,
                                                personsList[index].id);
                                          },
                                          child: Image.asset("images/bin.png")),
                                      InkWell(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                                'userUpdate',
                                                params: {
                                                  'name': personsList[index]
                                                      .name
                                                      .toString(),
                                                  'surname': personsList[index]
                                                      .surName
                                                      .toString(),
                                                  'phone': personsList[index]
                                                      .phone
                                                      .toString(),
                                                  'date': personsList[index]
                                                      .date
                                                      .toString(),
                                                  'tc': personsList[index]
                                                      .tc
                                                      .toString(),
                                                  'id': personsList[index]
                                                      .id
                                                      .toString(),
                                                  'book': personsList[index]
                                                      .bookName
                                                      .toString()
                                                });
                                          },
                                          child:
                                              Image.asset("images/changes.png"))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
