import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  String? name;

  int? price;

  int? category;

  int order = 0;

}

@collection
class Category {
  Id id = Isar.autoIncrement;

  String? categoryname;

  int order = 0;
}

@collection
class Flightprice {
  Id id = Isar.autoIncrement;

  DateTime? time;
  
  List<String> products = [];

  List<double> prices = [];
  
}