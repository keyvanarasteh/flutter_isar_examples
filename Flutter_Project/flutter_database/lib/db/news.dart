import 'package:isar/isar.dart';

part 'news.g.dart';

//Tablo oluşturma
@collection
class News {
  Id id = Isar.autoIncrement; //İçerik eklendikçe otomatik id artması
  String? title = "";
  String? content = "";
  String? imagePath = "";
  DateTime time = DateTime.now();
}
