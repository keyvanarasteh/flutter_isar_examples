// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendarscreen extends StatefulWidget {
  const Calendarscreen({super.key});

  @override
  State<Calendarscreen> createState() => _CalendarscreenState();
}

class _CalendarscreenState extends State<Calendarscreen> {
DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
   return Scaffold(
       body :Column(
        children: [
          Text("Tek gün seçimi :"),
          SfDateRangePicker(
            view:DateRangePickerView.month ,
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (e) {
              selectedDate = e.value;
              setState(() {});
            },
          ),
          Text("Seçilen Tarih :"),
          Text(DateFormat('E d MMMM yyyy ').format(selectedDate)),
           SizedBox(height: 5),
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey[900]),backgroundColor:MaterialStateProperty.all(Colors.grey[400])),
                      onPressed: (() {
                        context.push('/home');
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Menü Ekranına Dön"
                          ),
                           Icon(Icons.arrow_back,size: 35,)
                        ],
                      )
                      ),
        ],
      ) ,
    );
  }
}