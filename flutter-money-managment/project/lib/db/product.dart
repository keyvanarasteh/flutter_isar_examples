import 'package:flutter/src/widgets/basic.dart';
import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  String? name;

  double price = 0;

  int? category;

  int order = 0;

  DateTime? dateAdded;

  set timestamp(int timestamp) {}
}

@collection
class Product2 {
  Id id = Isar.autoIncrement;

  String? name;

  double price = 0;

  int? category;

  int order = 0;
}

@collection
class Category {
  Id id = Isar.autoIncrement;

  String? categoryName;

  int order = 0;

  static map(Row Function(dynamic e) param0) {}
}
