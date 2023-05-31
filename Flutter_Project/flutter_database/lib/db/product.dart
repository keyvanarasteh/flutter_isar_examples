import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;
  String? category;
  bool favorite = false;
  String? imgUrl = "";
  String? title;
  String? description;
  DateTime? favoriteTime;
  List<String> tags = [];
  double? price;
}
