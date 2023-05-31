import 'package:isar/isar.dart';

part 'earn.g.dart';

//Tablo oluşturma
@collection
class Earn {
  Id id = Isar.autoIncrement; //İçerik eklendikçe otomatik id artması
  String? title = "";
  String? description = "";
  double? earnValue;
  bool save = false;
  DateTime time = DateTime.now();
}
