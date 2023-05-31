import 'package:isar/isar.dart';
// id, title, note, amount, time
part 'cost.g.dart';


@Collection()
class Cost {
  Id? id = Isar.autoIncrement;

  String? title;

  String? note;

  double amount;

  int time;

  Cost({
    this.id,
    required this.title,
    required this.note,
    required this.amount,
    required this.time,
  });
}
