import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_package/custom_snackbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_odev/models/cost.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/income.dart';

DateFormat dateFormat = DateFormat('dd EEEE MMMM yyyy', 'tr_TR');

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Isar isar;
  String totalCount = '0';

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  var incomes = <Income>[];
  var costs = <Cost>[];
  late var subcription;

  @override
  initState() {
    super.initState();
    initIsar();
    getStatus();
    subcription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      String message;
      switch (result) {
        case ConnectivityResult.none:
          message = 'İnternet bağlantısı yok';
          break;
        case ConnectivityResult.mobile:
          message = 'İnternet bağlantısı mevcut: Mobil';
          break;
        case ConnectivityResult.wifi:
          message = 'İnternet bağlantısı mevcut: Wifi';
          break;
        case ConnectivityResult.ethernet:
          message = 'İnternet bağlantısı mevcut: Ethernet';
          break;
        case ConnectivityResult.vpn:
          message = 'İnternet bağlantısı mevcut: Vpn';
          break;
        case ConnectivityResult.bluetooth:
          message = 'İnternet bağlantısı mevcut: Bluetooth';
          break;
        case ConnectivityResult.other:
          message = 'İnternet bağlantısı mevcut: Other';
          break;
      }
      CustomSnackbar.showSnackbarCustom(context: context, string: message);
    });
  }

  @override
  dispose() {
    subcription.cancel();
    super.dispose();
  }

  getStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    String message;
    switch (connectivityResult) {
      case ConnectivityResult.none:
        message = 'İnternet bağlantısı yok';
        break;
      case ConnectivityResult.mobile:
        message = 'İnternet bağlantısı mevcut: Mobil';
        break;
      case ConnectivityResult.wifi:
        message = 'İnternet bağlantısı mevcut: Wifi';
        break;
      case ConnectivityResult.ethernet:
        message = 'İnternet bağlantısı mevcut: Ethernet';
        break;
      case ConnectivityResult.vpn:
        message = 'İnternet bağlantısı mevcut: Vpn';
        break;
      case ConnectivityResult.bluetooth:
        message = 'İnternet bağlantısı mevcut: Bluetooth';
        break;
      case ConnectivityResult.other:
        message = 'İnternet bağlantısı mevcut: Other';
        break;
    }
    CustomSnackbar.showSnackbarCustom(context: context, string: message);
  }

  initIsar() async {
    isar = (await Isar.getInstance())!;
    getCurrentCount();
  }

  insertIncome() async {
    var r = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context1, setState1) => AlertDialog(
            title: const Text('Gelir Ekle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                    ),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'Not',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                    decoration: const InputDecoration(
                      labelText: 'Tutar',
                    ),
                  ),
                  TextField(
                    controller: sourceController,
                    decoration: const InputDecoration(
                      labelText: 'Kaynak',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      showDialog<Widget>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: SfDateRangePicker(
                                showActionButtons: true,
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onSubmit: (p0) {
                                  print(p0);
                                  print(p0.runtimeType);
                                  if (p0 != null) {
                                    selectedDate = p0 as DateTime;
                                    setState(() {});
                                    setState1(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Tarih Seç: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Ekle'),
              ),
            ],
          ),
        );
      },
    );

    if (r != true) {
      return;
    }

    final income = Income(
      title: titleController.text,
      note: noteController.text,
      amount: double.parse(amountController.text),
      source: sourceController.text,
      time: selectedDate.millisecondsSinceEpoch,
    );
    await isar.writeTxn(() async {
      await isar.incomes.put(income);
    });
    clearControllers();
    getCurrentCount();
  }

  updateCost(Cost cost) async {
    titleController.text = cost.title ?? '';
    noteController.text = cost.note ?? '';
    amountController.text = cost.amount.toString();
    selectedDate = DateTime.fromMillisecondsSinceEpoch(cost.time);
    var r = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context1, setState1) => AlertDialog(
            title: const Text('Gider Güncelle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                    ),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'Not',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                    decoration: const InputDecoration(
                      labelText: 'Tutar',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      showDialog<Widget>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: SfDateRangePicker(
                                showActionButtons: true,
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onSubmit: (p0) {
                                  print(p0);
                                  print(p0.runtimeType);
                                  if (p0 != null) {
                                    selectedDate = p0 as DateTime;
                                    setState(() {});
                                    setState1(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Tarih Seç: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Güncelle'),
              ),
            ],
          ),
        );
      },
    );

    if (r == false) {
      return;
    }
    cost.title = titleController.text;
    cost.note = noteController.text;
    cost.amount = double.parse(amountController.text);
    cost.time = selectedDate.millisecondsSinceEpoch;
    await isar.writeTxn(() async {
      await isar.costs.put(cost);
    });
    clearControllers();
    getCurrentCount();
  }

  updateIncome(Income income) async {
    titleController.text = income.title ?? '';
    noteController.text = income.note ?? '';
    amountController.text = income.amount.toString();
    sourceController.text = income.source ?? '';
    selectedDate = DateTime.fromMillisecondsSinceEpoch(income.time);
    var r = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context1, setState1) => AlertDialog(
            title: const Text('Gelir Güncelle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                    ),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'Not',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                    decoration: const InputDecoration(
                      labelText: 'Tutar',
                    ),
                  ),
                  TextField(
                    controller: sourceController,
                    decoration: const InputDecoration(
                      labelText: 'Kaynak',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      showDialog<Widget>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: SfDateRangePicker(
                                showActionButtons: true,
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onSubmit: (p0) {
                                  print(p0);
                                  print(p0.runtimeType);
                                  if (p0 != null) {
                                    selectedDate = p0 as DateTime;
                                    setState(() {});
                                    setState1(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Tarih Seç: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Güncelle'),
              ),
            ],
          ),
        );
      },
    );

    if (r == false) {
      return;
    }
    income.title = titleController.text;
    income.note = noteController.text;
    income.amount = double.parse(amountController.text);
    income.source = sourceController.text;
    income.time = selectedDate.millisecondsSinceEpoch;
    await isar.writeTxn(() async {
      await isar.incomes.put(income);
    });
    clearControllers();
    getCurrentCount();
  }

  insertCost() async {
    var r = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context1, setState1) => AlertDialog(
            title: const Text('Gider Ekle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                    ),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'Not',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
                    decoration: const InputDecoration(
                      labelText: 'Tutar',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      showDialog<Widget>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: SfDateRangePicker(
                                showActionButtons: true,
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onSubmit: (p0) {
                                  print(p0);
                                  print(p0.runtimeType);
                                  if (p0 != null) {
                                    selectedDate = p0 as DateTime;
                                    setState(() {});
                                    setState1(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Tarih Seç: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Ekle'),
              ),
            ],
          ),
        );
      },
    );

    if (r != true) {
      return;
    }

    print(amountController.text);
    final cost = Cost(
      title: titleController.text,
      note: noteController.text,
      amount: double.parse(amountController.text),
      time: selectedDate.millisecondsSinceEpoch,
    );
    await isar.writeTxn(() async {
      await isar.costs.put(cost);
    });
    clearControllers();
    getCurrentCount();
  }

  removeIncome(Income income) async {
    await isar.writeTxn(() async {
      await isar.incomes.delete(income.id ?? 0);
    });
    getCurrentCount();
  }

  removeCost(Cost cost) async {
    await isar.writeTxn(() async {
      await isar.costs.delete(cost.id ?? 0);
    });
    getCurrentCount();
  }

  getCurrentCount() async {
    this.incomes = await isar.incomes.where().findAll();
    this.costs = await isar.costs.where().findAll();

    this.incomes.sort((a, b) => b.time.compareTo(a.time));
    this.costs.sort((a, b) => b.time.compareTo(a.time));

    double totalIncome = 0;
    for (var income in incomes) {
      totalIncome += income.amount;
    }

    double totalCost = 0;
    for (var cost in costs) {
      totalCost += cost.amount;
    }

    totalCount = (totalIncome - totalCost).toStringAsFixed(2);
    setState(() {});
    print('totalCount $totalCount');
  }

  clearControllers() async {
    titleController.clear();
    noteController.clear();
    amountController.clear();
    sourceController.clear();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Gelir - Gider'),
                    content: Container(
                      height: 300,
                      width: 300,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          sections: [
                            incomes.length > 0
                                ? PieChartSectionData(
                                    color: Colors.green,
                                    value: incomes.map((e) => e.amount).reduce((value, element) => value + element),
                                    title:
                                        '${incomes.map((e) => e.amount).reduce((value, element) => value + element)}₺',
                                    radius: 100,
                                    titleStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : PieChartSectionData(
                                    color: Colors.green,
                                    value: 0,
                                    title: '0₺',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                            costs.length > 0
                                ? PieChartSectionData(
                                    color: Colors.red,
                                    value: costs.map((e) => e.amount).reduce((value, element) => value + element),
                                    title: '${costs.map((e) => e.amount).reduce((value, element) => value + element)}₺',
                                    radius: 100,
                                    titleStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : PieChartSectionData(
                                    color: Colors.red,
                                    value: 0,
                                    title: '0₺',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Kapat'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.auto_graph_sharp,
              color: Colors.grey,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                print("tıklandı");
                GoRouter.of(context).replace(
                  '/filter',
                  extra: isar,
                );
              },
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.wallet_rounded, size: 50),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () async {
                        await insertCost();
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.remove_circle, color: Colors.red),
                          const SizedBox(height: 10),
                          Text('Gider Ekle', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )),
                  Column(
                    children: [
                      Text('Toplam Bakiye', style: Theme.of(context).textTheme.titleLarge),
                      Text('${totalCount} ₺', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      insertIncome();
                    },
                    child: Column(
                      children: [
                        const Icon(Icons.add_circle, color: Colors.green),
                        const SizedBox(height: 10),
                        Text('Gelir Ekle', style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: const [
                          Tab(text: 'Gelirler'),
                          Tab(text: 'Giderler'),
                        ],
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).primaryColor,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: incomes.length,
                              itemBuilder: (context, index) {
                                var date = DateTime.fromMillisecondsSinceEpoch(incomes[index].time);
                                return Dismissible(
                                  key: Key(incomes[index].id.toString()),
                                  onDismissed: (direction) async {
                                    await removeIncome(incomes[index]);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.delete, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      context.push('/detail/${incomes[index].id}/true');
                                    },
                                    leading: IconButton(
                                      onPressed: () async {
                                        await updateIncome(incomes[index]);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    title: Text(incomes[index].title ?? 'Title'),
                                    subtitle: Text('${incomes[index].note ?? 'Not yok'}\n${incomes[index].source}'),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${incomes[index].amount} ₺'),
                                        Text('${dateFormat.format(date)}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: costs.length,
                              itemBuilder: (context, index) {
                                var date = DateTime.fromMillisecondsSinceEpoch(costs[index].time);
                                return Dismissible(
                                  key: Key(costs[index].id.toString()),
                                  onDismissed: (direction) async {
                                    await removeCost(costs[index]);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.delete, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      context.push('/detail/${costs[index].id}/false');
                                    },
                                    leading: IconButton(
                                      onPressed: () async {
                                        await updateCost(costs[index]);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    title: Text(costs[index].title ?? 'Title'),
                                    subtitle: Text(costs[index].note ?? 'Note'),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${costs[index].amount} ₺'),
                                        Text('${dateFormat.format(date)}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
