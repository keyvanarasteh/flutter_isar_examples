import "package:isar/isar.dart";

part "library.g.dart";

@collection
class Library {
  Id id = Isar.autoIncrement;

  String? bookName;

  String? writerName;

  String? date;

  int? pageCount;
}
