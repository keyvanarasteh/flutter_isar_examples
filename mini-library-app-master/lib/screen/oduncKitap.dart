import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:databaseodev/database/library.dart';
import 'package:databaseodev/database/person.dart';
import 'package:databaseodev/widget/appBar.dart';
import 'package:databaseodev/widget/snackDesign.dart';
import 'package:databaseodev/widget/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class OduncKitap extends StatefulWidget {
  const OduncKitap({super.key});

  @override
  State<OduncKitap> createState() => _OduncKitapState();
}

class _OduncKitapState extends State<OduncKitap> {
  late Isar isar;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _identityController = TextEditingController();
  final _bookNameController = TextEditingController();
  final _dateController = TextEditingController();

  List<Person> personsList = [];
  List<Library> bookList = [];
  getUsers() async {
    final person = await isar.persons.where().findAll();
    setState(() {
      personsList = person;
    });
  }

  getBooks() async {
    final books = await isar.librarys.where().findAll();
    setState(() {
      bookList = books;
    });
  }

  @override
  void initState() {
    print("ekran calisti");
    // openConnection();

    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
    getBooks();
  }

  @override
  void dispose() {
    print("ekran kapandi");

    // closeConnection();
    super.dispose();
  }

  addPerson(String name, String surName, String phone, String tc,
      String bookName, String date) async {
    final person = Person()
      ..name = name
      ..surName = surName
      ..phone = phone
      ..tc = tc
      ..bookName = bookName
      ..date = date;

    if (bookName.isEmpty ||
        name.isEmpty ||
        date.isEmpty ||
        phone.isEmpty ||
        tc.isEmpty ||
        surName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackDesign(
            text1: "Tekrar Deneyin !",
            text2: "Bilgileri Doldurup Tekrardan Ekleme Yapmayı Deneyiniz !",
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
            text1: "Kişi Eklenmiştir !",
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

    await isar.writeTxn(() async => await isar.persons.put(person));
  }

  String? _selectedBook;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bookList.forEach((element) {
      // print(element.bookName);

      // _bookNameList.add(element.bookName.toString());
      // print(_bookNameList);
    });
    // var book;

    // for (book in bookList) {
    //   _bookNameList.add(book.bookName);
    // }
    // print(_bookNameList);
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
                  height: 25,
                ),
                Image.asset("images/online-library1.png"),
                SizedBox(
                  height: 15,
                ),
                Text("ÖDÜNÇ KİTAP", style: GoogleFonts.bebasNeue(fontSize: 36)),
                SizedBox(
                  height: 10,
                ),
                Text("Lütfen Bilgilerinizi Doldurunuz",
                    style: GoogleFonts.bebasNeue(fontSize: 18)),
                SizedBox(
                  height: 30,
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _nameController,
                  myHintText: "Kişi İsmi",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  myIcon: Image.asset("images/user.png"),
                  onChanged: () {},
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _surnameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  myHintText: "Kişi Soyismi",
                  myIcon: Image.asset("images/user.png"),
                  onChanged: () {},
                ),
                Padding(
                  padding: MyPadding.horizontal25,
                  child: Container(
                    decoration: BoxDecoration(
                        color: appColors.grey_200,
                        border: Border.all(color: appColors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: IntlPhoneField(
                      initialCountryCode: 'TR',
                      controller: _phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                          labelText: "Tel No", border: InputBorder.none),
                    ),
                  ),
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _dateController,
                  myHintText: "Teslim Alınan Tarih",
                  myIcon: Image.asset("images/date.png"),
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
                        _dateController.text =
                            DateFormat.yMMM().format(pickDate);
                      });
                    } else {
                      print("Not Selected");
                    }
                  },
                ),
                MyForm(
                  onChanged1: (p0) {},
                  myController: _identityController,
                  myHintText: "T.C. No",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(11),
                  ],
                  myIcon: Image.asset("images/id-card.png"),
                  onChanged: () {},
                ),
                Padding(
                  padding: MyPadding.together,
                  child: Container(
                    decoration: BoxDecoration(
                        color: appColors.grey_200,
                        border: Border.all(color: appColors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: MyPadding.onlyLeft,
                      child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.circular(12),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: appColors.grey),
                        value: _selectedBook,
                        hint: Text("Alınan Kitap İsmi"),
                        items: bookList.map((book) {
                          return DropdownMenuItem<String>(
                            value: book.bookName,
                            child: Text(book.bookName.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedBook = value;
                          });
                        },
                      ),
                    ),
                  ),
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
                            addPerson(
                              _nameController.text,
                              _surnameController.text,
                              _phoneController.text,
                              _identityController.text,
                              _selectedBook.toString(),
                              _dateController.text,
                            );
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
