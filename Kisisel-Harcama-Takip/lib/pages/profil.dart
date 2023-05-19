import 'package:flutter_icons/flutter_icons.dart';
import 'package:kisisel_takip/theme/renkler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:kisisel_takip/scoped_model/sema.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:kisisel_takip/pages/kullanici_ekle.dart';
import 'dart:convert';
import 'package:animations/animations.dart';


class ProfilePage extends StatefulWidget {
  final ExpenseModel model;
  ProfilePage({Key key, @required this.model}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController userControler = TextEditingController();
  TextEditingController categoryControler = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    userControler.dispose();
    categoryControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userControler.text = widget.model.getUsers.join(',');
    categoryControler.text = widget.model.getCategories.join(',');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: grey.withOpacity(0.05),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 56, //56 height of the bottom navigation bar
          child: getBody(),
        ));
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
            gradient: LinearGradient(
                colors: myColors[2],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 2.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 25),
            child: Row(
              children: <Widget>[],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Image.asset(
              "assets/images/budget.png",
              height: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "Kişisel Harcama Takip",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xfffe6f27),
              ),
            ),

            SizedBox(height: 13),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                closedElevation: 0,
                openElevation: 0,
                middleColor: Colors.transparent,
                openColor: Colors.transparent,
                closedColor: Colors.transparent,
                closedBuilder: (_, __) => Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 10),
                    Text(
                      "Kullanıcılar",
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    )
                  ],
                ),
                openBuilder: (_, __) => AddUserCat(context: context, type: 0),
              ),
              Divider(
                indent: 30,
                thickness: 1.0,
                height: 15,
              ),
              SizedBox(height: 10),
              OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                closedElevation: 0,
                openElevation: 0,
                middleColor: Colors.transparent,
                openColor: Colors.transparent,
                closedColor: Colors.transparent,
                closedBuilder: (_, __) => Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 10),
                    Text(
                      "Kategoriler",
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    )
                  ],
                ),
                openBuilder: (_, __) => AddUserCat(context: context, type: 1),
              ),
              Divider(
                indent: 30,
                thickness: 1.0,
                height: 15,
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: showResetDialog,
                child: Row(
                  children: [
                    Icon(FlutterIcons.restore_mco),
                    SizedBox(width: 10),
                    Text(
                      "Veritabanını Temizle",
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
        Expanded(child: Container()),
        Column(
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Copyright \u00a9',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " 2023, "),
                  TextSpan(
                    text: 'Hüseyin Beyazkılıç - Eray Fidan - Mahir Donmez',
                    style: TextStyle(color: Color(0xfffe6f27)),
                    recognizer: TapGestureRecognizer()..onTap = _launchURL,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 13,
            )
          ],
        ),
      ],
    );
  }

  var _url = '#';
  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  bool notContains(List<String> source, List<String> dest) {
    // check if any element of dest exists in dest
    for (String elem in dest) {
      if (!source.contains(elem)) {
        return true;
      }
    }
    return false;
  }

  void showResetDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Veritabanını Temizle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bütün verileri silmek istediğinize emin misiniz'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                widget.model.resetAll();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void loadUserData() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    String fileName = result.files.single.path;
    var data = json.decode(File(fileName).readAsStringSync());
    // print(data);
    List<String> _uList = (data["users"] as List).map((e) => e as String).toList();

    List<String> _cList = (data["categories"] as List).map((e) => e as String).toList();

    List<Map<String, dynamic>> _exList = (data["expenses"] as List).map((e) => Map<String, dynamic>.from(e)).toList();

    widget.model.newDataLoaded(_uList, _cList, _exList);
  }


}
