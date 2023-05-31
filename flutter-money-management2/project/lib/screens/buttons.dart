import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const CustomButton({
    required this.text,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22),
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 17, 1, 1).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  imagePath,
                  height: 50,
                ),
                SizedBox(width: 15),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
