import 'package:isar/isar.dart';
part 'cost.g.dart';

@collection
class Cost {
  Id id = Isar.autoIncrement;
  String? username;
  float? outgo;
  DateTime? mmonth;
  String? monthName;
}
