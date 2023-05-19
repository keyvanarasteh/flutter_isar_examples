import 'package:film_add/db/Users.dart';
import 'package:film_add/widgets/customAppbar2.dart';
import 'package:film_add/widgets/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class edituser extends StatefulWidget {
  final String? username;
  final String? name;
  const edituser({super.key, this.username, this.name});

  @override
  State<edituser> createState() => _edituserState();
}

class _edituserState extends State<edituser> {
  late Isar isar;
  String password = "";
  Edituser() async {
    final k = await isar.users
        .where()
        .filter()
        .usernameEqualTo(widget.username)
        .findFirst();
    final edittuser = User()
      ..mail = k?.mail
      ..name = k?.name
      ..username = k?.username
      ..id = k!.id
      ..pass = password;

    await isar.writeTxn(() async {
      await isar.users.put(edittuser);
      setState(() {});
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Düzenlendi"),
      ),
    );
  }

  TextEditingController passwordCollect = TextEditingController();
  @override
  void initState() {
    isar = Provider.of<Isar>(context, listen: false);
    // openConnetction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(200, 220, 244, 1),
      body: ListView(children: [
        Column(
          children: [
            customAppbar2(
                name: widget.name,
                username: widget.username,
                leftIcon: Icons.arrow_back_ios_new,
                rightIcon: Icons.manage_accounts_outlined),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: customtext(
                onChanged: (p0) {
                  setState(() {
                    password = p0;
                  });
                },
                hide: true,
                color: Colors.black,
                label: "Change Password",
                Icon: Icons.password_outlined,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: customtext(
                hide: true,
                color: Colors.black,
                label: "Confirm Password",
                Icon: Icons.password_outlined,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Edituser();
                GoRouter.of(context).push('/home');
              },
              child: Text("Kaydet"),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  minimumSize: MaterialStatePropertyAll(Size(350, 40))),
            )
          ],
        ),
      ]),
    );
  }
}
