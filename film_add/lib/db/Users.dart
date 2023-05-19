import 'package:film_add/db/cost.dart';
import 'package:film_add/db/income.dart';
import 'package:isar/isar.dart';

part 'Users.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  String? name;
  String? username;
  String? pass;
  String? mail;
  final gelir = IsarLink<Income>();
  final gider = IsarLink<Cost>();
}
