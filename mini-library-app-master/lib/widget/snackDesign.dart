import 'package:databaseodev/class/colors.dart';
import 'package:databaseodev/class/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class snackDesign extends StatelessWidget {
  const snackDesign({
    super.key,
    required this.text1,
    required this.text2,
    required this.colorSnack,
    required this.image,
    required this.image2,
  });
  final String text1;
  final String text2;
  final Color colorSnack;
  final Image image;
  final Image image2;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Container(
          padding: MyPadding.all,
          height: 100,
          decoration: BoxDecoration(
            color: colorSnack,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: GoogleFonts.acme(
                          fontSize: 18, color: appColors.white),
                    ),
                    Text(
                      text2,
                      style: GoogleFonts.acme(
                          fontSize: 16, color: appColors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          left: 15,
          child: image2,
        ),
        Positioned(top: 5, left: 10, child: image)
      ],
    );
  }
}
