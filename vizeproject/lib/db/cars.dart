import 'package:isar/isar.dart';

part 'cars.g.dart';

@collection
class Car {
  Id id = Isar.autoIncrement;

  String? carplate ;

  String? brand ;

  String? model ;

  int year = 0 ;

  double price = 0 ;
}