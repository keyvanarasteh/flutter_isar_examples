import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:databaseodev/database/library.dart';
import 'package:databaseodev/widget/appBar.dart';
import 'package:databaseodev/widget/snackDesign.dart';
import 'package:databaseodev/widget/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Isar isar;

  final _bookController = TextEditingController();
  final _dateController = TextEditingController();
  final _writerController = TextEditingController();
  final _pageCountController = TextEditingController();

  List<Library> booksList = [];
  // openConnection() async {
  //   isar = await Isar.open([LibrarySchema]);
  //   setState(() {});
  // }

  // closeConnection() async {
  //   await isar.close();
  // }
  // usersToWidget() {
  //   return booksList
  //       .map((e) => Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Text(e.bookName!),
  //                 SizedBox(
  //                   width: 5,
  //                 ),
  //                 Text(e.writerName.toString()),
  //                 SizedBox(
  //                   width: 5,
  //                 ),
  //                 Text("Tarih : " + e.date.toString()),
  //                 InkWell(
  //                   onTap: () {
  //                     // deleteBook(e.id);
  //                   },
  //                   child: Image.asset("images/trash.png"),
  //                 )
  //               ],
  //             ),
  //           ))
  //       .toList();
  // }

  addBooks(
      String writerName, String bookName, String date, String pageCount) async {
    final newBook = Library()
      ..bookName = bookName
      ..writerName = writerName
      ..date = date
      ..pageCount = int.tryParse(pageCount);

    if (bookName.isEmpty ||
        writerName.isEmpty ||
        date.isEmpty ||
        pageCount.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackDesign(
            text1: "Tekrar Deneyin !",
            text2: "Bilgileri Doldurup Tekrardan Ekleme Yapmayı Deneyiniz ! ",
            colorSnack: appColors.snackRed,
            image: Image.asset("images/danger.png"),
            image2: Image.asset("images/paint-splash (2).png"),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: appColors.transparent,
          elevation: 0,
        ),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackDesign(
            text1: "Kitap Kütüphaneye Eklenmiştir !",
            text2: "",
            colorSnack: appColors.snackGreen,
            image: Image.asset("images/ok.png"),
            image2: Image.asset("images/blur.png"),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: appColors.transparent,
          elevation: 0,
        ),
      );
    }

    await isar?.writeTxn(() async => await isar?.librarys.put(newBook));
    getUsers();
  }

  getUsers() async {
    // final users = await isar.users.get(8);
    final books = await isar?.librarys.where().findAll();
    // final users = await isar.users.getAll([8,1,5]); id si 8 5 ve 1 olanları alır.
    print(books);

    setState(() {});
  }

  // getLessPageCount() async {
  //   final books = await isar.librarys.filter().pageCountLessThan(150).findAll();
  //    await isar.librarys.filter().pageCountGreaterThan(250).findAll();
  //   booksList = books;
  //   setState(() {});
  // }
  @override
  void initState() {
    print("ekran calisti");
    // openConnection();
    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
  }

  @override
  void dispose() {
    print("ekran kapandi");

    // closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        path: '/mainPage',
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                ),
                Image.asset("images/online-library1.png"),
                SizedBox(
                  height: 15,
                ),
                Text("Kitap Ekle", style: GoogleFonts.bebasNeue(fontSize: 36)),
                SizedBox(
                  height: 10,
                ),
                Text("Eklemek İstediğiniz Kitap Bilgilerini Giriniz !",
                    style: GoogleFonts.bebasNeue(fontSize: 18)),
                SizedBox(
                  height: 40,
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _writerController,
                  myHintText: "Yazar İsmi",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  myIcon: Image.asset("images/ink (1).png"),
                  onChanged: () {},
                ),
                MyForm(
                  myController: _bookController,
                  myHintText: "Kitap İsmi",
                  myIcon: Image.asset("images/open-book.png"),
                  onChanged: () {},
                  onChanged1: (p0) {},
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _pageCountController,
                  myHintText: "Sayfa Sayısı",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  myIcon: Image.asset("images/open-book.png"),
                  onChanged: () {},
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _dateController,
                  myHintText: "İlk Baskı Yılı",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  myIcon: Image.asset("images/calendar.png"),
                  onChanged: () async {
                    DateTime? pickDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      initialDatePickerMode: DatePickerMode.year,
                      selectableDayPredicate: (DateTime val) =>
                          val.isBefore(DateTime.now()),
                    );
                    if (pickDate != null) {
                      setState(() {
                        _dateController.text = DateFormat('y').format(pickDate);
                      });
                    } else {
                      print("Not Selected");
                    }
                  },
                ),
                Padding(
                  padding: MyPadding.all,
                  child: AnimatedButton(
                    color: appColors.btn,
                    text: "Ekle",
                    pressEvent: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Adding",
                          desc: "Kitap bilgileri ekleniyor..",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            addBooks(
                                _writerController.text,
                                _bookController.text,
                                _dateController.text,
                                _pageCountController.text.toString());
                          }).show();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
