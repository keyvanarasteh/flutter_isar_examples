// ignore_for_file: prefer_const_constructors, avoid_init_to_null, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:splash_screen/widgets/Textfield.dart';
import 'package:vizeproject/db/transactions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class CarTransactionsScreen extends StatefulWidget {
  const CarTransactionsScreen({super.key});

  @override
  State<CarTransactionsScreen> createState() => _CarTransactionsScreenState();
}

class _CarTransactionsScreenState extends State<CarTransactionsScreen> {
  late Isar isar;

  DateTime selectedDate = DateTime.now();

  TextEditingController carplateController = TextEditingController();
  TextEditingController brandController = TextEditingController(); 
  TextEditingController transactionnameController = TextEditingController(); 
  TextEditingController priceController = TextEditingController();

  bool addMode = true;
  String carplate = "";
  String brand = "";
  String transactionname = "";
  double price = 0.0;
  List<Transactions> transactions = [];

  addTransactions() async{
    if(carplate.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       backgroundColor: Colors.red,
       content: Text('Plaka Boş Olamaz !'),
       ));
    }
    else if(brand.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       backgroundColor: Colors.red,
       content: Text('Marka Boş Olamaz !'),
       ));
    }
     else if(transactionname.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       backgroundColor: Colors.red,
       content: Text('İşlem Adı Boş Olamaz !'),
       ));
    }
    else{
      final newTransactions = Transactions()
    ..carplate = carplate 
    ..brand = brand 
    ..transactionname = transactionname 
    ..price = price ;

    await isar.writeTxn(() async {
      await isar.transactions.put(newTransactions);});

      carplateController = TextEditingController(text: "");
      brandController = TextEditingController(text: "");
      transactionnameController = TextEditingController(text: "");
      priceController = TextEditingController(text: "");
      getTransactions();
    }
  }

  RemoveTransactions(int transactionsId) async{
    await isar.writeTxn(() async{
        isar.transactions.delete(transactionsId);
        getTransactions();
      }
    );
  }

 void _showAlertDialog(BuildContext context, int carId) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Onay'),
        content: const Text('İşlemi silmek istediğinizden emin misiniz?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Hayır'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              RemoveTransactions(carId);
            },
            child: const Text('Evet'),
          ),
        ],
      ),
    );
  }

  getTransactions() async {

    transactions = await isar.transactions.where().sortByPrice().findAll();
    setState(() {});
}

List<Widget> carsWidgets() {
 if(transactions.isEmpty){
  return [Center(child: Text("Kayıtlı İşlem Bulunamadı!"))];
 }
 else{
   return transactions.map((e) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(e.carplate!),
      Text(e.brand!),
      Text(e.transactionname!),
      Text(e.price.toString()),
      Row(
        children: [
          ElevatedButton(onPressed: () {
            addMode = false; 
            carplate = e.carplate!;
            brand = e.brand!;
            transactionname = e.transactionname!;
            price = e.price;          
            carplateController.text =  e.carplate!;
            brandController.text = e.brand!;
            transactionnameController.text = e.transactionname!;
            priceController.text = e.price.toString();
          }, child:Icon(Icons.edit)),
          SizedBox(width: 5),
          ElevatedButton(onPressed: () {_showAlertDialog(context, e.id);addMode=true; setState(() {});}, child:Icon(Icons.remove)),
        ],
      ),
    ],
  )).toList();
 }
}

openConnection() async {
  try{
  isar = await Isar.open([TransactionsSchema]);
  getTransactions();
  }
  catch (e){}
  setState(() {});
}

closeConnection() async {
  try{
  await isar.close();
   }
  catch (e){}
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
    return Scaffold(
      appBar: AppBar(
        title: Text('İşlemler'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  getTransactions();
                },
                icon: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('    Araç Plakası:'),
            SizedBox(height: 8),
            FilledTextField(
              hint: ' Araç Plakası',
              controller: carplateController,
              icon: Icon(Icons.text_fields),
              onChanged: (value) {
                setState(() {
                  carplate = value;
                });
              },
            ),
            SizedBox(height: 8),
            Text('    Araç Markası:'),
            SizedBox(height: 8),
            FilledTextField(
              hint: 'Araç Markası',
              controller: brandController,
              icon: Icon(Icons.car_rental),
              onChanged: (value) {
                setState(() {
                  brand = value;
                });
              },
            ),
             SizedBox(height: 8),
            Text('    İşlem Adı'),
            SizedBox(height: 8),
            FilledTextField(
              hint: 'İşlem Adı',
              controller: transactionnameController,
              icon: Icon(Icons.car_crash_rounded),
              onChanged: (value) {
                setState(() {
                  transactionname = value;
                });
              },
            ),
             SizedBox(height: 8),
            Text('    İşlem Fiyatı: '),
            SizedBox(height: 8),
            FilledTextField(
              hint: 'İşlem Fiyatı ',
              icon: Icon(Icons.attach_money),
              controller: priceController,
              number: true,
              onChanged: (value) {
                try {
                  if (value.isEmpty) {
                    price = 0;
                  } else {
                    price = double.parse(value);
                  }
                  setState(() {});
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Fiyatın Sayi olmasi gerekiyor.'),
                  ));
                }
              },
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          addTransactions();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(addMode ? 'Ekle' : 'Düzenle'),
                            ],
                          ),
                        ))),
                SizedBox(width: 5.0),
                !addMode
                    ? Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              addMode = true;
                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.cancel),
                                  Text('Iptal Et'),
                                ],
                              ),
                            )))
                    : SizedBox(),
                    ],
            ),
            SizedBox(height: 18),
            Expanded(
                child: ListView(
              children:carsWidgets(),
            ))
          ],
        ),
      ),
    );
  }
}