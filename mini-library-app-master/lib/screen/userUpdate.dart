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

class UserUpdate extends StatefulWidget {
  UserUpdate(
      {super.key,
      required this.name,
      required this.surname,
      required this.phone,
      required this.date,
      required this.tc,
      required this.id,
      required this.book});
  String? name;
  String? surname;
  String? phone;
  String? date;
  String? tc;
  String? book;
  int id;
  @override
  State<UserUpdate> createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  late Isar isar;
  final _dateController = TextEditingController();

  List<Person> personsList = [];
  List<Library> bookList = [];

  getBooks() async {
    final books = await isar.librarys.where().findAll();
    setState(() {
      bookList = books;
    });
  }

  editPerson(int id, String name, String surName, String phone, String tc,
      String bookName, String date) async {
    final person = Person()
      ..id = id
      ..name = name
      ..surName = surName
      ..phone = phone
      ..tc = tc
      ..bookName = bookName
      ..date = date;

    if (bookName.isEmpty ||
        tc.isEmpty ||
        name.isEmpty ||
        surName.isEmpty ||
        phone.isEmpty ||
        date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: snackDesign(
            text1: "Dikkat ! ",
            text2: "Lütfen Bilgileri Doldurunuz !  ",
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
            text1: "Bilgileriniz Güncellenmiştir.",
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
    getBooks();
  }

  @override
  void dispose() {
    print("ekran kapandi");

    // closeConnection();
    super.dispose();
  }

  String? _selectedBook;
  @override
  Widget build(BuildContext context) {
    String? updateName = widget.name;
    String? updateSurName = widget.surname;
    String? updatePhone = widget.phone;
    String? updateDate = widget.date;
    String? updateTc = widget.tc;
    print(updateTc);
    return Scaffold(
      appBar: appBar(
        path: '/oduncAlan',
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
                Text("Bilgileri Güncelle ",
                    style: GoogleFonts.bebasNeue(fontSize: 36)),
                SizedBox(
                  height: 10,
                ),
                Text("Lütfen Bilgilerinizi Doldurunuz !",
                    style: GoogleFonts.bebasNeue(fontSize: 18)),
                SizedBox(
                  height: 30,
                ),
                MyForm(
                  onChanged1: (p0) {
                    updateName = p0;
                  },
                  myController: TextEditingController(text: widget.name),
                  myHintText: "Kişi İsmi",
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  myIcon: Image.asset("images/user.png"),
                  onChanged: () {},
                ),
                MyForm(
                  onChanged1: (p0) {
                    updateSurName = p0;
                  },
                  myController: TextEditingController(text: widget.surname),
                  myHintText: "Kişi Soyismi",
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
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
                      onChanged: (e) {
                        updatePhone = e.number;
                      },
                      initialCountryCode: 'TR',
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: TextEditingController(text: widget.phone),
                      decoration: InputDecoration(
                          labelText: "Tel No", border: InputBorder.none),
                    ),
                  ),
                ),
                MyForm(
                  onChanged1: (p0) {
                    updateDate = p0;
                  },
                  myController: TextEditingController(text: widget.date),
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
                        widget.date = DateFormat.yMMM().format(pickDate);
                      });
                    } else {
                      print("Not Selected");
                    }
                  },
                ),
                MyForm(
                  onChanged1: (p0) {
                    updateTc = widget.tc;
                  },
                  myController: TextEditingController(text: widget.tc),
                  myHintText: "T.C. No",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(11),
                  ],
                  myIcon: Image.asset("images/id-card.png"),
                  onChanged: () {
                    // updateTc = TextEditingController(text: widget.tc).text;
                  },
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
                        value: widget.book,
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
                    text: "Güncelle",
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
                            editPerson(
                                widget.id,
                                updateName.toString(),
                                updateSurName.toString(),
                                updatePhone.toString(),
                                updateTc.toString(),
                                _selectedBook.toString(),
                                updateDate.toString());
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
