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

class BookUpdate extends StatefulWidget {
  BookUpdate({
    required this.id,
    required this.writerName,
    required this.bookName,
    required this.pageCount,
    required this.date,
    super.key,
  });

  int id;
  String? writerName;
  String? bookName;
  String? pageCount;
  String? date;
  @override
  State<BookUpdate> createState() => _BookUpdateState();
}

class _BookUpdateState extends State<BookUpdate> {
  late Isar isar;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bookNameController = TextEditingController();
  final _dateController = TextEditingController();

  List<Library> bookList = [];

  editBook(int id, String bookName, String writerName, int pageCount,
      String date) async {
    final library = Library()
      ..id = id
      ..bookName = bookName
      ..writerName = writerName
      ..pageCount = pageCount
      ..date = date;

    if (bookName.isEmpty ||
        writerName.isEmpty ||
        pageCount.toString().isEmpty ||
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

    await isar.writeTxn(() async => await isar.librarys.put(library));
  }

  getBook() async {
    final book = await isar.librarys.where().findAll();
    setState(() {
      bookList = book;
    });
  }

  @override
  void initState() {
    print("ekran calisti");
    // openConnection();

    super.initState();
    isar = Provider.of<Isar>(context, listen: false);
    getBook();
  }

  @override
  void dispose() {
    print("ekran kapandi");

    // closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? updateBookName = widget.bookName;
    String? updateWriterName = widget.writerName;
    String? updatePageCount = widget.pageCount;
    String? updateDate = widget.date;

    return Scaffold(
      appBar: appBar(path: '/listBook'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 55,
                ),
                Image.asset("images/online-library1.png"),
                SizedBox(
                  height: 15,
                ),
                Text("Güncelleme Ekranı  ",
                    style: GoogleFonts.bebasNeue(fontSize: 36)),
                SizedBox(
                  height: 10,
                ),
                Text("Güncellemek İstediğiniz Bilgileri Değiştirin",
                    style: GoogleFonts.bebasNeue(fontSize: 18)),
                SizedBox(
                  height: 40,
                ),
                MyForm(
                  onChanged1: (p0) {
                    updateWriterName = p0;
                  },
                  myController: TextEditingController(text: widget.writerName),
                  myHintText: "Yazar İsmi",
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  myIcon: Image.asset("images/ink (1).png"),
                  onChanged: () {},
                ),
                MyForm(
                  myController: TextEditingController(text: widget.bookName),
                  myHintText: "Kitap İsmi",
                  myIcon: Image.asset("images/open-book.png"),
                  onChanged: () {},
                  onChanged1: (p0) {
                    updateBookName = p0;
                  },
                ),
                MyForm(
                  onChanged1: (p0) {
                    updatePageCount = p0;
                  },
                  myController:
                      TextEditingController(text: widget.pageCount.toString()),
                  myHintText: "Sayfa Sayısı",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  myIcon: Image.asset("images/open-book.png"),
                  onChanged: () {},
                ),
                MyForm(
                  onChanged1: (p0) {
                    updateDate = p0;
                  },
                  myController: TextEditingController(text: widget.date),
                  myHintText: "İlk Baskı Yılı",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                        widget.date = DateFormat('y').format(pickDate);
                      });
                    } else {
                      print("Not Selected");
                    }
                  },
                ),
                Padding(
                  padding: MyPadding.together,
                  child: AnimatedButton(
                    color: appColors.btn,
                    text: "Güncelle",
                    pressEvent: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Güncelleniyor",
                          desc: "Kitap bilgileri güncelleniyor..",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            editBook(
                                widget.id,
                                updateBookName.toString(),
                                updateWriterName.toString(),
                                int.parse(updatePageCount.toString()),
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
