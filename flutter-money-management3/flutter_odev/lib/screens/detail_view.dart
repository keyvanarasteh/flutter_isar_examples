import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../models/cost.dart';
import '../models/income.dart';
import 'home_view.dart';

class DetailView extends StatefulWidget {
  final String id;
  final String isIncome;
  DetailView({super.key, required this.id, required this.isIncome});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Isar isar;
  Income? income;
  Cost? cost;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initIsar();
  }

  initIsar() async {
    isar = (await Isar.getInstance())!;
    getDetail();
  }

  getDetail() {
    print('neye girdi ${widget.isIncome}');
    if (widget.isIncome == 'true') {
      income = isar.incomes.where().idEqualTo(int.parse(widget.id)).findFirstSync();
    } else {
      cost = isar.costs.where().idEqualTo(int.parse(widget.id)).findFirstSync();
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detay'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : widget.isIncome == 'true'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Başlık: ${income?.title ?? 'Title'}'),
                      Text('Açıklama: ${income?.note ?? 'Not yok'}'),
                      Text('Kaynak: ${income?.source}'),
                      Text('Tutar: ${income?.amount} ₺'),
                      Text('Tarih: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(income!.time))}'),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Başlık: ${cost?.title ?? 'Title'}'),
                      Text('Açıklama: ${cost?.note ?? 'Not yok'}'),
                      Text('Tutar: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(cost!.time))} ₺'),
                      // Text('Tarih: ${cost?.day}.${cost?.month}.${cost?.year}'),
                    ],
                  ),
      ),
    );
  }
}
