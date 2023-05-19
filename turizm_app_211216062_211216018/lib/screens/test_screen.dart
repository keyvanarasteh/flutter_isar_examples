// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../db/user.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Isar isar;

  //List<Widget> UsersList = [];
  List<User> usersList = [];
  
  // veritabani islemlerimiz
  addUser(
    String name,
    String mothername,
    String fathername,
    int age,
    String birthPlace,
    String phone,
  ) async {
    final newUser = User()
      ..name = name
      ..fathername = fathername
      ..mothername = mothername
      ..age = age
      ..birthPlace = birthPlace
      ..phone = phone;

    await isar.writeTxn(() async => await isar.users.put(newUser));
    getUsers();
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kullanıcı eklendi")));
  }
  
  editUser(
    int id,
    String name,
    String mothername,
    String fathername,
    int age,
    String birthPlace,
    String phone,
  ) async {
    final user = User()
      ..id = id
      ..name = name
      ..fathername = fathername
      ..mothername = mothername
      ..age = age
      ..birthPlace = birthPlace
      ..phone = phone;
    
    await isar.writeTxn(() async => await isar.users.put(user));
    getUsers();
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kullanıcı eklendi")));
  }

  deleteUser(int id) async {
    await isar.writeTxn(() async {
    bool result = await isar.users.delete(id);
    if (result) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Kullanıcı silindi ")));
      getUsers();
    } else {
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Kullanıcı silinemedi !")));
    }
    });
   
    
  }

  usersToWidget() {
    return usersList
        .map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(e.name!),
                  SizedBox(
                    width: 5,
                  ),
                  Text(e.id.toString()),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Yas:" + e.age.toString()),
                  ElevatedButton(
                      onPressed: () => deleteUser(e.id),
                      child: Icon(Icons.delete))
                ],
              ),
            ))
        .toList();
  }

  getUsers() async {
    final users = await isar.users.where().findAll();
    usersList = users;
    setState(() {});
  }

  getYoungUsers() async {
    final users = await isar.users.filter().ageLessThan(20).findAll();
    usersList = users;
    setState(() {});
  }

  getOldUsers() async {
    final users = await isar.users.filter().ageGreaterThan(20).findAll();
    usersList = users;
    setState(() {});
  }

  openConnection() async {
    isar = await Isar.open([UserSchema]);
    setState(() {});
  }

  closeConnection() async {
    await isar.close();
  }

  @override
  void initState() {
    print("ekran calisti");
    openConnection();
    super.initState();
  }

  @override
  void dispose() {
    print("ekran kapandi");
    closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () =>
                    addUser("Dogan Sari", "X", "Y", 21, "Istanbul", "0552"),
                child: Text("Ekle")),
            ElevatedButton(
                onPressed: getUsers, child: Text("Kullanıcıları Listele")),
            ElevatedButton(
                onPressed: getYoungUsers, child: Text("20 yasdan kücükler")),
            ElevatedButton(
                onPressed: getOldUsers, child: Text("20 yasdan büyükler")),
            ElevatedButton(
                onPressed:() {
                 editUser(1,"Selen", "X", "Y", 21, "Istanbul", "0552");
                 },
                child: Text("Edit 1 Banday")),
            Expanded(
                child: ListView(
              children: usersToWidget(),
            
            ))
          ],
        ));
  }
}
