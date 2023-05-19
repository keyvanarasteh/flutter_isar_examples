import 'package:isar/isar.dart';
part 'income.g.dart';

@collection
class Income {
  Id id = Isar.autoIncrement;
  String? username;
  float? draw;
  DateTime? mmonth;
  String? monthName;
}
