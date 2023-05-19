// ignore_for_file: prefer_const_constructors

import 'package:film_add/widgets/balance.dart';
import 'package:film_add/widgets/customAppbar.dart';
import 'package:film_add/widgets/money.dart';
import 'package:film_add/widgets/nameInfo.dart';
import 'package:film_add/widgets/organizator.dart';
import 'package:flutter/material.dart';

class mScreen extends StatefulWidget {
  final String? name;
  final String? username;
  const mScreen({super.key, this.name, this.username});

  @override
  State<mScreen> createState() => _mScreenState();
}

class _mScreenState extends State<mScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 220, 244, 1),
      body: ListView(children: [
        Column(
          children: [
            customAppbar(
                username: widget.username,
                name: widget.name,
                lpath: '/home',
                rpath: '/edit',
                leftIcon: Icons.arrow_back_ios_new,
                rightIcon: Icons.manage_accounts_outlined),
            infoName(name: widget.name),
            balance(username: widget.username),
            organizator(
              name: widget.name,
              username: widget.username,
            ),
            SizedBox(height: 28),
            money(username: widget.username),
          ],
        ),
      ]),
    );
  }
}
