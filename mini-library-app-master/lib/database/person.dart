import "package:isar/isar.dart";

part "person.g.dart";

@collection
class Person {
  Id id = Isar.autoIncrement;

  String? name;

  String? surName;

  String? phone;

  String? tc;

  String? bookName;

  String? date;
}
