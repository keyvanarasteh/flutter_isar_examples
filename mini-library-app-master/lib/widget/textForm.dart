import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  MyForm(
      {super.key,
      this.myController,
      this.myHintText,
      this.myIcon,
      required this.onChanged1,
      this.inputFormatters,
      required this.onChanged});
  //add variable myController
  final TextEditingController? myController;
  final String? myHintText;
  final Image? myIcon;
  final void Function() onChanged;
  final void Function(String) onChanged1;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyPadding.textFormPadding,
      child: Container(
        decoration: BoxDecoration(
            color: appColors.grey_200,
            border: Border.all(color: appColors.white),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: MyPadding.textFormLeft,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onChanged,
            onChanged: widget.onChanged1,
            controller: widget.myController,
            decoration: InputDecoration(
              hintText: widget.myHintText,
              border: InputBorder.none,
              suffixIcon: widget.myIcon,
            ),
          ),
        ),
      ),
    );
  }
}
