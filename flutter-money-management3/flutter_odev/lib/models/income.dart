import 'package:isar/isar.dart';
// id, title, note, amount, source, time
part 'income.g.dart';


@Collection()
class Income {
  Id? id = Isar.autoIncrement;

  String? title;

  String? note;

  double amount;

  String? source;

  int time;

  Income({
    this.id,
    required this.title,
    required this.note,
    required this.amount,
    required this.source,
    required this.time,
  });
}