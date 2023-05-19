import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:kisisel_takip/scoped_model/sema.dart';
import 'package:kisisel_takip/theme/renkler.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:collection/collection.dart';

class NewEntryLog extends StatefulWidget {
  final Function callback;
  final BuildContext context;
  final int index;
  NewEntryLog({Key key, this.callback, this.context, this.index = -999})
      : super(key: key);
  @override
  _NewEntryLogState createState() => _NewEntryLogState();
}

class _NewEntryLogState extends State<NewEntryLog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _itemEditor = TextEditingController();
  TextEditingController _personEditor = TextEditingController();
  TextEditingController _amountEditor = TextEditingController();
  TextEditingController _dateEditor =
      TextEditingController(text: DateTime.now().toString());
  TextEditingController _categoryEditor = TextEditingController();
  List<TextEditingController> _shareControler;

  Map<String, String> shareList;
  ExpenseModel model;
  bool showError = false;
  List<String> _users;
  List<double> _sharedRatio;

  bool editRecord;

  @override
  void dispose() {
    super.dispose();
    _itemEditor.dispose();
    _personEditor.dispose();
    _amountEditor.dispose();
    _dateEditor.dispose();
    _categoryEditor.dispose();
    _shareControler.forEach((element) {
      element.dispose();
    });
  }

  @override
  void initState() {
    model = ScopedModel.of(widget.context);
    super.initState();
    editRecord = widget.index != -999;
    _users = model.getUsers;

    if (editRecord) {
      Map<String, dynamic> data = {...model.getExpenses[widget.index]};
      _itemEditor.text = data['item'];
      _personEditor.text = data['person'];
      _amountEditor.text = data['amount'];
      _dateEditor.text =
          DateFormat("dd-MM-yyyy").parse(data['date']).toString();
      _categoryEditor.text = data['category'];
      shareList =
          Map<String, String>.from(model.getExpenses[widget.index]["shareBy"]);

      // fill users if not present
      if (_users.length != shareList.length) {
        for (String u in model.getUsers) {
          if (!shareList.containsKey(u)) {
            shareList[u] = "0.00";
          }
        }
      }
      _sharedRatio = _users
          .map((e) => double.parse((double.parse(shareList[e]) *
                  _users.length /
                  double.parse(data['amount']))
              .toStringAsFixed(2)))
          .toList();
    } else {
      shareList = {for (var u in model.getUsers) u: "0.00"};
      _sharedRatio = _users.map((e) => 1.0).toList();
    }
    _shareControler =
        _users.map((e) => TextEditingController(text: shareList[e])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffe6f27),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (editRecord) model.deleteExpense(widget.index);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
            tooltip: "Sil",
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: (model.getUsers.length == 0 || model.getCategories.length == 0)
            ? Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Kullanıcı ve kategori eklenmedi",
                      style: TextStyle(fontSize: 21),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {
                          widget.callback(3);
                          Navigator.pop(context);
                        },
                        child: Text("Ayarlara git"))
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.shopping_cart_outlined),
                          hintText: 'Parayı ne alarak harcadın',
                          labelText: 'Eşya',
                        ),
                        controller: _itemEditor,
                        validator: (value) =>
                            value.isEmpty ? "Doldurulması gerek *" : null,
                      ),
                      SizedBox(height: 9),
                      SelectFormField(
                        icon: Icon(Icons.person_outline),
                        labelText: 'Kim aldı',
                        controller: _personEditor,
                        items: model.getUsers
                            .map((e) => {
                                  "value": e,
                                  "label": e,
                                })
                            .map((e) => Map<String, dynamic>.from(
                                e)) // select form field items require <String,dynamic>
                            .toList(),
                        validator: (value) =>
                            value.isEmpty ? "Doldurulması gerek *" : null,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.number,
                        controller: _amountEditor,
                        onChanged: (value) {
                          updateSharingDetails();
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_balance_wallet_outlined),
                          hintText: 'Bunun için ne kadar harcadın?',
                          labelText: "Fiyat",
                        ),
                        validator: (val) {
                          if (val.isEmpty) return "Doldurulması gerek *";
                          if (double.tryParse(val) == null) {
                            return "Geçerli bir sayı gir";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      DateTimePicker(
                        controller: _dateEditor,
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Tarih',
                        validator: (value) =>
                            value.isEmpty ? "Doldurulması gerek *" : null,
                      ),
                      SizedBox(height: 9),
                      SelectFormField(
                        // key: ValueKey<int>(count2),
                        autovalidate: false,
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        controller: _categoryEditor,
                        icon: Icon(Icons.category),
                        hintText: 'Kategoriyi seçiniz',
                        labelText: 'Kategori',
                        items: model.getCategories
                            .map((e) => {
                                  "value": e,
                                  "label": e,
                                })
                            .map((e) => Map<String, dynamic>.from(e))
                            .toList(),

                        validator: (value) =>
                            value.isEmpty ? "Required field *" : null,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: clearForm,
              child: Text(
                "Kaydet ve başka harcama ekle",
                style: TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
            ),
            TextButton(
              onPressed: () {
                bool saved = saveRecord();
                if (saved) {
                  widget.callback(0); //move to log page
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Kaydet",
                style: TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveRecord() {
    print('saverecord');
    if (formKey.currentState.validate() && sharedProperly()) {
      Map<String, dynamic> data = {
        "date": DateFormat('dd-MM-yyyy')
            .format(DateFormat('yyyy-MM-dd').parse(_dateEditor.text)),
        "person": _personEditor.text,
        "item": _itemEditor.text,
        "category": _categoryEditor.text,
        "amount": _amountEditor.text,
        "shareBy": shareList
      };
      editRecord
          ? model.editExpense(widget.index, data)
          : model.addExpense(data);
      return true;
    }
  }

  clearForm() {
    bool saved = saveRecord();
    if (!saved) return;
    formKey.currentState.reset();
    _itemEditor.clear();
    _amountEditor.clear();
    // keep the person selector, category selector and date as it is while clearing the form
    // _personEditor?.clear();
    // _categoryEditor.clear();
    // _dateEditor.text = DateTime.now().toString();
    shareList = {for (var u in model.getUsers) u: "0.00"};
    _sharedRatio = _users.map((e) => 1.0).toList();
    // _checkList = _users.map((_) => false).toList();
    for (TextEditingController e in _shareControler) {
      e.text = "0.00";
    }
    _shareControler =
        _users.map((e) => TextEditingController(text: shareList[e])).toList();
    editRecord = false;
    setState(() {});
  }

  sharedProperly() {
    double val = double.parse(_amountEditor.text);
    if (val == null) return false;

    for (int i = 0; i < _users.length; i++) {
      shareList[_users[i]] =
          double.parse(_shareControler[i].text).toStringAsFixed(2);
    }

    List<double> sharedAmount =
        _users.map((e) => double.parse(shareList[e])).toList(); //
    double summed = sharedAmount.sum;
    int len = _users.length;

    if (summed == val) {
      _sharedRatio = sharedAmount
          .map((e) => double.parse((e * len / summed).toStringAsFixed(2)))
          .toList();
      showError = false;
      setState(() {});

      return true;
    } else {
      showError = true;
      setState(() {});

      return false;
    }
  }

  // updateRatio(String val, int index) {
  //   double thisAmount = double.parse(val);

  // }

  updateSharingDetails() {
    if (_amountEditor.text.trim().isEmpty) {
      return;
    }
    double value = double.parse(_amountEditor.text);

    List<double> iAmount = _sharedRatio
        .map((e) =>
            double.parse((value * e / _sharedRatio.sum).toStringAsFixed(2)))
        .toList();

    double diff = value;
    for (double e in iAmount) {
      diff -= e;
    }

    if (diff != 0) {
      for (int i = 0; i < _users.length; i++) {
        if (_sharedRatio[i] != 0) {
          iAmount[i] += diff;
          break;
        }
      }
    }
    for (int i = 0; i < _users.length; i++) {
      _shareControler[i].text = iAmount[i].toStringAsFixed(2);
      shareList[_users[i]] = iAmount[i].toStringAsFixed(2);
    }
    setState(() {});
  }
}
