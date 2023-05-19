import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import 'db/Users.dart';
import 'widgets/text.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late Isar isar;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String username = "";
  String name = "";
  String pass = "";
  String mail = "";
  bool goster = true;
  addUser() async {
    if (name.isEmpty || pass.isEmpty || mail.isEmpty || username.isEmpty) {
      goster = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Çalışan bilgilerini girmeniz gerekiyor'),
      ));
    } else {
      goster = true;
      final newUser = User()
        ..name = name
        ..username = username
        ..mail = mail
        ..pass = pass;

      await isar.writeTxn(() async {
        await isar.users.put(newUser);

        usernameController = TextEditingController(text: "");
        passwordController = TextEditingController(text: "");
        emailController = TextEditingController(text: "");
        nameController = TextEditingController(text: "");
        setState(() {});
      });
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
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: const Center(
                    child: Text("Welcome",
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 60,
                            fontStyle: FontStyle.italic)),
                  ),
                  width: screenWidth,
                  height: 330,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                    color: new Color(0xff1f3b83),
                    gradient: LinearGradient(
                      colors: [
                        new Color(0xff058cc0),
                        (const Color.fromARGB(255, 202, 215, 248))
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("         Adını giriniz:",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      temp: nameController,
                      hide: false,
                      hint_text: "  Name",
                      icon: Icons.account_circle_outlined,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("        Kullanıcı adını giriniz:",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      temp: usernameController,
                      hide: false,
                      hint_text: "  User Name",
                      icon: Icons.account_box_outlined,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("        Mail Adresinizi giriniz:",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      onChanged: (value) {
                        setState(() {
                          mail = value;
                        });
                      },
                      temp: emailController,
                      hide: false,
                      hint_text: "  Mail Adress",
                      icon: Icons.mail_outlined,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("        Şifrenizi giriniz:",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(
                      height: 10,
                    ),
                    text(
                      onChanged: (value) {
                        setState(() {
                          pass = value;
                        });
                      },
                      temp: passwordController,
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
                      addUser();
                      if (goster) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Eklendi'),
                        ));
                      }
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
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.cyan,
                  label: const Text("Go Back"),
                  onPressed: () {
                    context.push("/home");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
