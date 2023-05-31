import 'package:db_api/db_api.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final String userID;
  const UserScreen({super.key, required this.userID});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isLoading = false;
  Map<String, dynamic> myUser = {
    "first_name": "-",
    "last_name": "-",
    "email": "-",
    "avatar": "https://freesvg.org/img/1544764567.png",
  };

  loadUser() async {
    isLoading = true;
    setState(() {});

    final api = API();
    final user = await api.getUser(widget.userID);

// Baglantı kontrol edilmesi
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Hata Oluştu")));
    } else {
      myUser = user["data"];
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(7.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(7.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(myUser["avatar"]),
                radius: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(myUser["first_name"] + " " + myUser["last_name"])
                ],
              ),
              Text(myUser["email"] + " " + myUser["last_name"]),
            ],
          ),
        ),
      ),
    );
  }
}
