// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../db/product.dart';

class RangePicker extends StatefulWidget {
  const RangePicker({super.key});

  @override
  State<RangePicker> createState() => _RangePickerState();
}

class _RangePickerState extends State<RangePicker> {
  late Isar isar;
  List<Category> categories = [];
  List<Product> products = [];
  List<Flightprice> toplampara = [];

  DateTime? startDate = DateTime.now();

  DateTime? endDate = DateTime.now();

  addFligt() async {
    final fligtticket = Flightprice();

    await isar.writeTxn(() async {
      await isar.flightprices.put(fligtticket);
    });
  }

  openConnection() async {
    try {
      isar =
          await Isar.open([CategorySchema, ProductSchema, FlightpriceSchema]);
      getCategories();
      getProducts();
    } catch (e) {}
    setState(() {});
  }

  closeConnection() async {
    try {
      await isar.close();
    } catch (e) {}
  }

  getProducts() async {
    products = await isar.products.where().sortByOrder().findAll();
    setState(() {});
  }

  getCategories() async {
    categories = await isar.categorys.where().sortByOrder().findAll();
    setState(() {});
  }

  @override
  void initState() {
    openConnection();

    super.initState();
  }

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 29, 32, 36),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => GoRouter.of(context).pop('/home'),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white24,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Text(
                          'Tarih Aralığı Seçimi',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(color: Colors.white)),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(color: Colors.white)),
                yearCellStyle: DateRangePickerYearCellStyle(
                    textStyle: TextStyle(color: Colors.white)),
                onSelectionChanged: (e) {
                  PickerDateRange x = e.value;
                  if (x.startDate != null && x.endDate != null) {
                    startDate = x.startDate!;
                    endDate = x.endDate!;
                  } else if (x.startDate != null && x.endDate == null) {
                    startDate = x.startDate;
                    endDate = null;
                  } else {}

                  setState(() {});
                },
              ),
              Text(
                'Baslangic Tarihi:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                DateFormat('E d MMMM yyyy').format(startDate!),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Bitis Tarihi:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              endDate != null
                  ? Text(
                      DateFormat('E d MMMM yyyy').format(endDate!),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      'Bitis tarihi yok',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
