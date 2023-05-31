import 'package:flutter/material.dart';
import 'package:db_api/db_api.dart';
import 'package:go_router/go_router.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  bool isLoading = false;
  List<dynamic> myUsers = [];
  loadUsers() async {
    isLoading = true;

    setState(() {});

    //Kutuphane Çagırma
    var api = API();
    final users = await api.getUsers();
    if (users != null) {
      myUsers = users["data"];

      isLoading = false;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Hata Oluştu")));
    }
  }

//Ekran açıldığında çalışan kod bloğu
  @override
  void initState() {
    loadUsers();
    super.initState();
  }

//Ekran kapandığında çalışan kod bloğu
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            isLoading ? LinearProgressIndicator() : SizedBox(),
            Expanded(
                child: ListView(
              children: myUsers
                  .map((e) => InkWell(
                        onTap: () {
                          GoRouter.of(context).push('/user/${e["id"]}');
                        },
                        child: Container(
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
                                backgroundImage: NetworkImage(e["avatar"]),
                                radius: 45,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(e["first_name"] + " " + e["last_name"])
                                ],
                              ),
                              Text(e["email"] + " " + e["last_name"]),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }
}
