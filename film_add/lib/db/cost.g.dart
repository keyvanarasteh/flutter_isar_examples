// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCostCollection on Isar {
  IsarCollection<Cost> get costs => this.collection();
}

const CostSchema = CollectionSchema(
  name: r'Cost',
  id: 4162002918781457506,
  properties: {
    r'mmonth': PropertySchema(
      id: 0,
      name: r'mmonth',
      type: IsarType.dateTime,
    ),
    r'monthName': PropertySchema(
      id: 1,
      name: r'monthName',
      type: IsarType.string,
    ),
    r'outgo': PropertySchema(
      id: 2,
      name: r'outgo',
      type: IsarType.float,
    ),
    r'username': PropertySchema(
      id: 3,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _costEstimateSize,
  serialize: _costSerialize,
  deserialize: _costDeserialize,
  deserializeProp: _costDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _costGetId,
  getLinks: _costGetLinks,
  attach: _costAttach,
  version: '3.0.5',
);

int _costEstimateSize(
  Cost object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.monthName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _costSerialize(
  Cost object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.mmonth);
  writer.writeString(offsets[1], object.monthName);
  writer.writeFloat(offsets[2], object.outgo);
  writer.writeString(offsets[3], object.username);
}

Cost _costDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Cost();
  object.id = id;
  object.mmonth = reader.readDateTimeOrNull(offsets[0]);
  object.monthName = reader.readStringOrNull(offsets[1]);
  object.outgo = reader.readFloatOrNull(offsets[2]);
  object.username = reader.readStringOrNull(offsets[3]);
  return object;
}

P _costDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readFloatOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _costGetId(Cost object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _costGetLinks(Cost object) {
  return [];
}

void _costAttach(IsarCollection<dynamic> col, Id id, Cost object) {
  object.id = id;
}

extension CostQueryWhereSort on QueryBuilder<Cost, Cost, QWhere> {
  QueryBuilder<Cost, Cost, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CostQueryWhere on QueryBuilder<Cost, Cost, QWhereClause> {
  QueryBuilder<Cost, Cost, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Cost, Cost, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Cost, Cost, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Cost, Cost, QAfterWhereClause> idBetween(
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

extension CostQueryFilter on QueryBuilder<Cost, Cost, QFilterCondition> {
  QueryBuilder<Cost, Cost, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Cost, Cost, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Cost, Cost, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Cost, Cost, QAfterFilterCondition> mmonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mmonth',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> mmonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mmonth',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> mmonthEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mmonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> mmonthGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mmonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> mmonthLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mmonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> mmonthBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mmonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monthName',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monthName',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monthName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monthName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monthName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monthName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthName',
        value: '',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> monthNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monthName',
        value: '',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> outgoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'outgo',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> outgoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'outgo',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> outgoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outgo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> outgoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outgo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> outgoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outgo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> outgoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outgo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<Cost, Cost, QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension CostQueryObject on QueryBuilder<Cost, Cost, QFilterCondition> {}

extension CostQueryLinks on QueryBuilder<Cost, Cost, QFilterCondition> {}

extension CostQuerySortBy on QueryBuilder<Cost, Cost, QSortBy> {
  QueryBuilder<Cost, Cost, QAfterSortBy> sortByMmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByMmonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByMonthName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByMonthNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByOutgo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outgo', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByOutgoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outgo', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension CostQuerySortThenBy on QueryBuilder<Cost, Cost, QSortThenBy> {
  QueryBuilder<Cost, Cost, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByMmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByMmonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByMonthName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByMonthNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByOutgo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outgo', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByOutgoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outgo', Sort.desc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Cost, Cost, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension CostQueryWhereDistinct on QueryBuilder<Cost, Cost, QDistinct> {
  QueryBuilder<Cost, Cost, QDistinct> distinctByMmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mmonth');
    });
  }

  QueryBuilder<Cost, Cost, QDistinct> distinctByMonthName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cost, Cost, QDistinct> distinctByOutgo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outgo');
    });
  }

  QueryBuilder<Cost, Cost, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension CostQueryProperty on QueryBuilder<Cost, Cost, QQueryProperty> {
  QueryBuilder<Cost, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Cost, DateTime?, QQueryOperations> mmonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mmonth');
    });
  }

  QueryBuilder<Cost, String?, QQueryOperations> monthNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthName');
    });
  }

  QueryBuilder<Cost, double?, QQueryOperations> outgoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outgo');
    });
  }

  QueryBuilder<Cost, String?, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
