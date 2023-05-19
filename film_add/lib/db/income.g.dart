// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetIncomeCollection on Isar {
  IsarCollection<Income> get incomes => this.collection();
}

const IncomeSchema = CollectionSchema(
  name: r'Income',
  id: -267602993667790363,
  properties: {
    r'draw': PropertySchema(
      id: 0,
      name: r'draw',
      type: IsarType.float,
    ),
    r'mmonth': PropertySchema(
      id: 1,
      name: r'mmonth',
      type: IsarType.dateTime,
    ),
    r'monthName': PropertySchema(
      id: 2,
      name: r'monthName',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 3,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _incomeEstimateSize,
  serialize: _incomeSerialize,
  deserialize: _incomeDeserialize,
  deserializeProp: _incomeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _incomeGetId,
  getLinks: _incomeGetLinks,
  attach: _incomeAttach,
  version: '3.0.5',
);

int _incomeEstimateSize(
  Income object,
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

void _incomeSerialize(
  Income object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeFloat(offsets[0], object.draw);
  writer.writeDateTime(offsets[1], object.mmonth);
  writer.writeString(offsets[2], object.monthName);
  writer.writeString(offsets[3], object.username);
}

Income _incomeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Income();
  object.draw = reader.readFloatOrNull(offsets[0]);
  object.id = id;
  object.mmonth = reader.readDateTimeOrNull(offsets[1]);
  object.monthName = reader.readStringOrNull(offsets[2]);
  object.username = reader.readStringOrNull(offsets[3]);
  return object;
}

P _incomeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readFloatOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _incomeGetId(Income object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _incomeGetLinks(Income object) {
  return [];
}

void _incomeAttach(IsarCollection<dynamic> col, Id id, Income object) {
  object.id = id;
}

extension IncomeQueryWhereSort on QueryBuilder<Income, Income, QWhere> {
  QueryBuilder<Income, Income, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IncomeQueryWhere on QueryBuilder<Income, Income, QWhereClause> {
  QueryBuilder<Income, Income, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Income, Income, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Income, Income, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Income, Income, QAfterWhereClause> idBetween(
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

extension IncomeQueryFilter on QueryBuilder<Income, Income, QFilterCondition> {
  QueryBuilder<Income, Income, QAfterFilterCondition> drawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'draw',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> drawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'draw',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> drawEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> drawGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'draw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> drawLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'draw',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> drawBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'draw',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> mmonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mmonth',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> mmonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mmonth',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> mmonthEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mmonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> mmonthGreaterThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> mmonthLessThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> mmonthBetween(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monthName',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monthName',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameEqualTo(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameGreaterThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameLessThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameBetween(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameStartsWith(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameEndsWith(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameContains(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameMatches(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthName',
        value: '',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> monthNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monthName',
        value: '',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameEqualTo(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameGreaterThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameLessThan(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameBetween(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameStartsWith(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameEndsWith(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameMatches(
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

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<Income, Income, QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension IncomeQueryObject on QueryBuilder<Income, Income, QFilterCondition> {}

extension IncomeQueryLinks on QueryBuilder<Income, Income, QFilterCondition> {}

extension IncomeQuerySortBy on QueryBuilder<Income, Income, QSortBy> {
  QueryBuilder<Income, Income, QAfterSortBy> sortByDraw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draw', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByDrawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draw', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByMmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByMmonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByMonthName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByMonthNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension IncomeQuerySortThenBy on QueryBuilder<Income, Income, QSortThenBy> {
  QueryBuilder<Income, Income, QAfterSortBy> thenByDraw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draw', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByDrawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draw', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByMmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByMmonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mmonth', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByMonthName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByMonthNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthName', Sort.desc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Income, Income, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension IncomeQueryWhereDistinct on QueryBuilder<Income, Income, QDistinct> {
  QueryBuilder<Income, Income, QDistinct> distinctByDraw() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'draw');
    });
  }

  QueryBuilder<Income, Income, QDistinct> distinctByMmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mmonth');
    });
  }

  QueryBuilder<Income, Income, QDistinct> distinctByMonthName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Income, Income, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension IncomeQueryProperty on QueryBuilder<Income, Income, QQueryProperty> {
  QueryBuilder<Income, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Income, double?, QQueryOperations> drawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'draw');
    });
  }

  QueryBuilder<Income, DateTime?, QQueryOperations> mmonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mmonth');
    });
  }

  QueryBuilder<Income, String?, QQueryOperations> monthNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthName');
    });
  }

  QueryBuilder<Income, String?, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
