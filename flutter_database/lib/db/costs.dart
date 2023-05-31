import 'package:isar/isar.dart';

part 'costs.g.dart';

//Tablo oluşturma
@collection
class Cost {
  Id id = Isar.autoIncrement; //İçerik eklendikçe otomatik id artması
  String? title = "";
  String? description = "";
  double? cost;
  bool save = false;
  DateTime time = DateTime.now();
}
