// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
DateTime selectedDate = DateTime.now();

showFormatedDate(){
  if (selectedDate != null)
  {
    var tarihim = DateFormat('yyyy MMM dd  EEEE --- kk:mm').format(selectedDate);
    return Text(tarihim);
  }
  else
  {
    return Text("Tarih Yok");
  }
}

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [   
                showFormatedDate(), 
                Expanded(child: Image.asset("images/car2.jpeg"), flex: 6),        
                    SizedBox(width: 15),
                    ElevatedButton(
                      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        GoRouter.of(context).push('/cartransactions');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Araç  Servis  Ekranı"),
                           Icon(Icons.car_repair_rounded,size: 35,)
                        ],
                      )
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        context.push('/carsales');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Araç   Satış   Ekranı"
                          ),
                           Icon(Icons.car_rental_sharp,size: 35,)
                        ],
                      )
                      ),
                       SizedBox(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        context.push('/calendar');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Takvim Ekranı "
                          ),
                           Icon(Icons.calendar_month_outlined,size: 35,)
                        ],
                      )
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        context.push('/chart');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Çizelge Ekranını "
                          ),
                           Icon(Icons.bar_chart,size: 35,)
                        ],
                      )
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        context.push('/enter');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Başlangıç Ekranını"
                          ),
                           Icon(Icons.arrow_back,size: 35,)
                        ],
                      )
                      ),
                  SizedBox(height: 5),            
              ],
            ), 
      ),
    );
  }
}