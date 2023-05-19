import 'package:film_add/db/cost.dart';
import 'package:film_add/widgets/customAppbar.dart';
import 'package:film_add/widgets/customAppbar2.dart';
import 'package:film_add/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class addCost extends StatefulWidget {
  final String? username;
  final String? name;

  const addCost({super.key, this.username, this.name});

  @override
  State<addCost> createState() => _addCostState();
}

class _addCostState extends State<addCost> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  late Isar isar;
  late float money;
  late String ayin_adi = DateFormat.LLLL().format(DateTime.now());
  late DateTime? selectedDate = DateTime.now();
  addUser() async {
    final adduser = await Cost()
      ..username = widget.username
      ..outgo = money
      ..mmonth = selectedDate
      ..monthName = ayin_adi;
    await isar.writeTxn(() async {
      await isar.costs.put(adduser);
      setState(() {});
    });
  }

  @override
  void initState() {
    dateInput.text = "";
    isar = Provider.of<Isar>(context, listen: false);
    // openConnetction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 220, 244, 1),
      body: ListView(children: [
        Column(
          children: [
            customAppbar2(
                name: widget.name,
                username: widget.username,
                leftIcon: Icons.arrow_back_ios_new,
                rightIcon: Icons.manage_accounts_outlined),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("         Çıkarmak İstediğiniz Miktarı Giriniz:",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(
              height: 10,
            ),
            text(
              onChanged: (value) {
                setState(() {
                  money = float.parse(value);
                });
              },
              temp: moneyController,
              hide: false,
              hint_text: "  Value",
              icon: Icons.money,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: dateInput,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(3000));

              if (pickedDate != null) {
                print(pickedDate);
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(formattedDate);
                setState(() {
                  dateInput.text = formattedDate;
                  selectedDate = DateTime.parse(formattedDate);
                  ayin_adi = DateFormat.LLLL().format(pickedDate);
                });
              } else {}
            },
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                addUser();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("EKLE"),
              )),
        )
      ]),
    );
  }
}
