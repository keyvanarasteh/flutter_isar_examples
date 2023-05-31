import 'package:isar/isar.dart';

part 'example_table.g.dart';

//Tablo oluşturma
@collection
class Example {
  Id id = Isar.autoIncrement; //İçerik eklendikçe otomatik id artması
  int? priority;
  String? title = "";
  String? content = "";
  String? imagePath = "";
  double? price;
  double? cost;
  DateTime time = DateTime.now();
}
