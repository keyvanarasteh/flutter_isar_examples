import 'package:isar/isar.dart';

part 'transactions.g.dart';

@collection
class Transactions {
  Id id = Isar.autoIncrement;

  String? carplate ;

  String? brand ;

  String? transactionname  ;

  double price = 0 ;
}