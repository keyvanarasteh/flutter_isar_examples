import 'package:isar/isar.dart';
part 'book.g.dart';

@collection
class Book {
  Id id = Isar.autoIncrement;
  String? name = "";
  String? writer = "";
  String? subject = "";
  String? imageBook = "";
  String? imageWriter = "";
  bool? favorite = false;
  double? price = 0;
  int? stok = 0;
}