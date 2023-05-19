import 'dart:developer';
import 'dart:ffi';

import 'package:film_add/db/Users.dart';
import 'package:film_add/screen/main_screen.dart';
import 'package:film_add/widgets/nameInfo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import 'widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

//kullanıcı adını ve şifreyi girince giriş ekranı kaldı aşağıdakigiriş butonu şu anda çalışmıyor
class _HomeState extends State<Home> {
  late Isar isar;
  TextEditingController Username = TextEditingController();
  TextEditingController Password = TextEditingController();
  String username = "";
  String password = "";
  bool flag = false;
  checkUser() async {
    final user =
        await isar.users.where().filter().usernameEqualTo(username).findAll();
    for (var i in user) {
      String dbusername = i.username.toString();
      String dbpass = i.pass.toString();

      if (dbusername == username && dbpass == password) {
        flag = true;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return mScreen(
              //kullanıcı adını da atabiliriz bilgileri değiştirmek için.
              username: dbusername,
              name: i.name.toString(),
            );
          },
        ));
        // GoRouter.of(context).push('/screen1');
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Şifreniz Hatalı.'),
          ));
        });
      }
    }
    if (user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Böyle Bir Kullanıcı Bulunamamaktadır'),
      ));
    }
  }

  @override
  void initState() {
    isar = Provider.of<Isar>(context, listen: false);
    // openConnetction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text("Welcome",
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 60,
                            fontStyle: FontStyle.italic)),
                  ),
                  width: screenWidth,
                  height: 330,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                    color: new Color(0xff1f3b83),
                    gradient: LinearGradient(
                      colors: [
                        new Color(0xff058cc0),
                        (Color.fromARGB(255, 202, 215, 248))
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("        Kullanıcı adını giriniz:",
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    text(
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      temp: Username,
                      hide: false,
                      hint_text: "  User Name",
                      icon: Icons.account_box_outlined,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("        Şifrenizi giriniz:",
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    text(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      temp: Password,
                      hide: true,
                      hint_text: "  Password",
                      icon: Icons.password_outlined,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      if (flag) {
                      } else {
                        checkUser();
                      }

                      // GoRouter.of(context).push('/screen1');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: new Color(0xff1f3b83),
                        gradient: LinearGradient(
                          colors: [
                            (new Color(0xff058cc0)),
                            new Color(0xff058cc0)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight / 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont't have account ? "),
                      GestureDetector(
                        onTap: (() {
                          GoRouter.of(context).push('/register');
                        }),
                        child: Text(
                          "Register Now",
                          style: TextStyle(color: Color(0xff058cc0)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
