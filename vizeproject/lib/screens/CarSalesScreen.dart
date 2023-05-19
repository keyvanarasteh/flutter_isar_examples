// ignore_for_file: prefer_const_constructors, empty_catches, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:splash_screen/widgets/Textfield.dart';
import 'package:vizeproject/db/cars.dart';


class CarSalesScreen extends StatefulWidget {
  const CarSalesScreen({super.key});

  @override
  State<CarSalesScreen> createState() => _CarSalesScreenState();
}

class _CarSalesScreenState extends State<CarSalesScreen> {
  late Isar isar;

  TextEditingController carplateController = TextEditingController();
  TextEditingController brandController = TextEditingController(); 
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool addMode = true;
  String carplate = "";
  String brand = "";
  String model = "";
  int year = 0;
  double price = 0.0;
  List<Car> cars = [];

  addCar() async{
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
     else if(model.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       backgroundColor: Colors.red,
       content: Text('Model Boş Olamaz !'),
       ));
    }
    else{
      final newCar = Car()
    ..carplate = carplate 
    ..brand = brand 
    ..model = model 
    ..year = year 
    ..price = price ;

    await isar.writeTxn(() async {
      await isar.cars.put(newCar);});

      carplateController = TextEditingController(text: "");
      brandController = TextEditingController(text: "");
      modelController = TextEditingController(text: "");
      yearController = TextEditingController(text: "");
      priceController = TextEditingController(text: "");
      getCar();
    }
  }

  removeCar(int carId) async{

    
    await isar.writeTxn(() async{
        isar.cars.delete(carId);
        getCar();
      }
    );
  }

 void _showAlertDialog(BuildContext context, int carId) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Onay'),
        content: const Text('Aracı silmek istediğinizden emin misiniz?'),
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
              removeCar(carId);
            },
            child: const Text('Evet'),
          ),
        ],
      ),
    );
  }

  getCar() async {

    cars = await isar.cars.where().sortByPrice().findAll();
    setState(() {});
}

List<Widget> carsWidgets() {
 if(cars.isEmpty){
  return [Center(child: Text("Kayıtlı Araç Bulunamadı!"))];
 }
 else{
   return cars.map((e) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(e.carplate!),
      Text(e.brand!),
      Text(e.model!),
      Text(e.year.toString()),
      Text(e.price.toString()),
      Row(
        children: [
          ElevatedButton(onPressed: () {
            addMode = false; 
            carplate = e.carplate!;
            brand = e.brand!;
            model = e.model!;
            year = e.year;
            price = e.price;          
            carplateController.text =  e.carplate!;
            brandController.text = e.brand!;
            modelController.text = e.model!;
            yearController.text = e.year.toString();
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
  isar = await Isar.open([CarSchema]);
  getCar();
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
        title: Text('Araçlar'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  getCar();
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
            Text('    Araç Modeli'),
            SizedBox(height: 8),
            FilledTextField(
              hint: 'Araç Modeli',
              controller: modelController,
              icon: Icon(Icons.car_crash_rounded),
              onChanged: (value) {
                setState(() {
                  model = value;
                });
              },
            ),
             SizedBox(height: 8),
            Text('    Araç Yılı '),
            SizedBox(height: 8),
            FilledTextField(
              hint: 'Araç Yılı',
              icon: Icon(Icons.date_range_outlined),
              controller: yearController,
              number: true,
              onChanged: (value) {
                try {
                  if (value.isEmpty) {
                    year = 0;
                  } else {
                    year = int.parse(value);
                  }
                  setState(() {});
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Yılın Sayi olmasi gerekiyor.'),
                  ));
                }
              },
            ),
            SizedBox(height: 8),
            Text('    Araç Fiyatı: '),
            SizedBox(height: 8),
            FilledTextField(
              hint: 'Araç Fiyatı ',
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
                          addCar();
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