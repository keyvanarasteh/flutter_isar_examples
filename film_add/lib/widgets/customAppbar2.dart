import 'dart:developer';

import 'package:film_add/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class customAppbar2 extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final String? name;
  final String? username;
  const customAppbar2({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
    this.name,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return mScreen(
                        //kullanıcı adını da atabiliriz bilgileri değiştirmek için.
                        username: username,
                        name: name,
                      );
                    },
                  ));
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(245, 241, 237, 1)),
                  child: Icon(leftIcon),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(245, 241, 237, 1)),
                child: Icon(rightIcon),
              )
            ],
          )),
    );
  }
}
