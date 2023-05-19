import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:databaseodev/database/library.dart';
import 'package:databaseodev/screen/bookUpdate.dart';
import 'package:databaseodev/widget/appBar.dart';
import 'package:databaseodev/widget/snackDesign.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ListBook extends StatefulWidget {
  const ListBook({super.key});

  @override
  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  late Isar isar;
  late List<Library> bookList = [];

  getUsers() async {
    final books = await isar.librarys.where().findAll();
    setState(() {
      bookList = books;
    });
  }

  editBooks(int id, String bookName, String writerName, int pageCount,
      String date) async {
    final book = Library()
      ..id = id
      ..writerName = writerName
      ..pageCount = pageCount
      ..bookName = bookName
      ..date = date;
    await isar.writeTxn(() async => await isar.librarys.put(book));
  }

  @override
  void initState() {
    print("ekran calisti");
    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
    getUsers();
  }

  @override
  void dispose() {
    print("ekran kapandi");

    super.dispose();
  }

  bool _isAlertVisible = false;

  // QuickAlert'ı gizlemek için kullanılan fonksiyon
  void _dismissAlert() {
    setState(() {
      _isAlertVisible = false;
    });
  }

  deleteBook(int id) async {
    await isar.writeTxn(() async {
      bool result = await isar.librarys.delete(id);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: snackDesign(
              text1: "Dikkat ! ",
              text2: "Seçilen Kitap Kaldırılmıştır ! ",
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
              text1: "Kitap Bulunamamıştır ",
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
          deleteBook(Index);
          _dismissAlert();
          Timer(Duration(seconds: 1), () {
            Navigator.of(context, rootNavigator: true)
                .pop(); // QuickAlert'ı kapatmak için kullanılır
          });
        });
  }

  final double _borderRadius = 24;
  List<String> books = [];
  @override
  Widget build(BuildContext context) {
    bookList.forEach((element) {
      print(element.bookName);
    });
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(path: '/mainPage'),
        body: bookList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Kitap Listeniz Boş Lütfen Kitap Ekleyiniz !"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedButton(
                    width: width * 0.5,
                    color: appColors.btn,
                    text: "Kitap Ekleyiniz ! ",
                    pressEvent: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Ekleme Ekranı Açılsın mı ?",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            GoRouter.of(context).pushNamed("/secondPage");
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
                      itemCount: bookList.length,
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
                                          'images/bookshelf.png',
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
                                              "Kitap İsmi",
                                              style: TextStyle(
                                                  color: appColors.grey,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              bookList[index]
                                                  .bookName
                                                  .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontSize: 16,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              "Yazar İsmi",
                                              style: TextStyle(
                                                color: appColors.grey,
                                                fontSize: 16,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              bookList[index]
                                                  .writerName
                                                  .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontSize: 16,
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
                                              "İlk Baskı Yılı",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appColors.grey,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              bookList[index].date.toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontSize: 16,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              "Sayfa Sayısı",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appColors.grey,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            Text(
                                              bookList[index]
                                                  .pageCount
                                                  .toString(),
                                              style: TextStyle(
                                                color: appColors.black,
                                                fontSize: 16,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
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
                                                bookList[index].id);

                                            // print(personsList[index].id);
                                          },
                                          child: Image.asset("images/bin.png")),
                                      InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => BookUpdate(
                                            //       id: bookList[index].id,
                                            //       bookName: bookList[index].bookName,
                                            //       date: bookList[index].date,
                                            //       pageCount: bookList[index]
                                            //           .pageCount
                                            //           .toString(),
                                            //       writerName:
                                            //           bookList[index].writerName,
                                            //     ),
                                            //   ),
                                            // );
                                            GoRouter.of(context).pushNamed(
                                              'bookUpdate',
                                              params: {
                                                'bookName': bookList[index]
                                                    .bookName
                                                    .toString(),
                                                'writerName': bookList[index]
                                                    .writerName
                                                    .toString(),
                                                'date': bookList[index]
                                                    .date
                                                    .toString(),
                                                'id': bookList[index]
                                                    .id
                                                    .toString(),
                                                'pageCount': bookList[index]
                                                    .pageCount
                                                    .toString(),
                                              },
                                            );
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
