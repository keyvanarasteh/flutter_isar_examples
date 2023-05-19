// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetTransactionsCollection on Isar {
  IsarCollection<Transactions> get transactions => this.collection();
}

const TransactionsSchema = CollectionSchema(
  name: r'Transactions',
  id: -3666024191998772642,
  properties: {
    r'brand': PropertySchema(
      id: 0,
      name: r'brand',
      type: IsarType.string,
    ),
    r'carplate': PropertySchema(
      id: 1,
      name: r'carplate',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 2,
      name: r'price',
      type: IsarType.double,
    ),
    r'transactiondate': PropertySchema(
      id: 3,
      name: r'transactiondate',
      type: IsarType.dateTime,
    ),
    r'transactionname': PropertySchema(
      id: 4,
      name: r'transactionname',
      type: IsarType.string,
    )
  },
  estimateSize: _transactionsEstimateSize,
  serialize: _transactionsSerialize,
  deserialize: _transactionsDeserialize,
  deserializeProp: _transactionsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _transactionsGetId,
  getLinks: _transactionsGetLinks,
  attach: _transactionsAttach,
  version: '3.0.5',
);

int _transactionsEstimateSize(
  Transactions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.brand;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.carplate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.transactionname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transactionsSerialize(
  Transactions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.brand);
  writer.writeString(offsets[1], object.carplate);
  writer.writeDouble(offsets[2], object.price);
  writer.writeString(offsets[4], object.transactionname);
}

Transactions _transactionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Transactions();
  object.brand = reader.readStringOrNull(offsets[0]);
  object.carplate = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.price = reader.readDouble(offsets[2]);
  object.transactionname = reader.readStringOrNull(offsets[4]);
  return object;
}

P _transactionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transactionsGetId(Transactions object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transactionsGetLinks(Transactions object) {
  return [];
}

void _transactionsAttach(
    IsarCollection<dynamic> col, Id id, Transactions object) {
  object.id = id;
}

extension TransactionsQueryWhereSort
    on QueryBuilder<Transactions, Transactions, QWhere> {
  QueryBuilder<Transactions, Transactions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransactionsQueryWhere
    on QueryBuilder<Transactions, Transactions, QWhereClause> {
  QueryBuilder<Transactions, Transactions, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionsQueryFilter
    on QueryBuilder<Transactions, Transactions, QFilterCondition> {
  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      brandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brand',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      brandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brand',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> brandEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      brandGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> brandLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> brandBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      brandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> brandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> brandContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> brandMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carplate',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carplate',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carplate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'carplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'carplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'carplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'carplate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carplate',
        value: '',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      carplateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carplate',
        value: '',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition> priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactiondateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transactiondate',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactiondateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transactiondate',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactiondateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactiondate',
        value: value,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactiondateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactiondate',
        value: value,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactiondateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactiondate',
        value: value,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactiondateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactiondate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transactionname',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transactionname',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transactionname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transactionname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transactionname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transactionname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionname',
        value: '',
      ));
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterFilterCondition>
      transactionnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transactionname',
        value: '',
      ));
    });
  }
}

extension TransactionsQueryObject
    on QueryBuilder<Transactions, Transactions, QFilterCondition> {}

extension TransactionsQueryLinks
    on QueryBuilder<Transactions, Transactions, QFilterCondition> {}

extension TransactionsQuerySortBy
    on QueryBuilder<Transactions, Transactions, QSortBy> {
  QueryBuilder<Transactions, Transactions, QAfterSortBy> sortByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> sortByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> sortByCarplate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carplate', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> sortByCarplateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carplate', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      sortByTransactiondate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactiondate', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      sortByTransactiondateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactiondate', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      sortByTransactionname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionname', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      sortByTransactionnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionname', Sort.desc);
    });
  }
}

extension TransactionsQuerySortThenBy
    on QueryBuilder<Transactions, Transactions, QSortThenBy> {
  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByCarplate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carplate', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByCarplateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carplate', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      thenByTransactiondate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactiondate', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      thenByTransactiondateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactiondate', Sort.desc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      thenByTransactionname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionname', Sort.asc);
    });
  }

  QueryBuilder<Transactions, Transactions, QAfterSortBy>
      thenByTransactionnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionname', Sort.desc);
    });
  }
}

extension TransactionsQueryWhereDistinct
    on QueryBuilder<Transactions, Transactions, QDistinct> {
  QueryBuilder<Transactions, Transactions, QDistinct> distinctByBrand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transactions, Transactions, QDistinct> distinctByCarplate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carplate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transactions, Transactions, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<Transactions, Transactions, QDistinct>
      distinctByTransactiondate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactiondate');
    });
  }

  QueryBuilder<Transactions, Transactions, QDistinct> distinctByTransactionname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionname',
          caseSensitive: caseSensitive);
    });
  }
}

extension TransactionsQueryProperty
    on QueryBuilder<Transactions, Transactions, QQueryProperty> {
  QueryBuilder<Transactions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Transactions, String?, QQueryOperations> brandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brand');
    });
  }

  QueryBuilder<Transactions, String?, QQueryOperations> carplateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carplate');
    });
  }

  QueryBuilder<Transactions, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<Transactions, DateTime?, QQueryOperations>
      transactiondateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactiondate');
    });
  }

  QueryBuilder<Transactions, String?, QQueryOperations>
      transactionnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionname');
    });
  }
}
