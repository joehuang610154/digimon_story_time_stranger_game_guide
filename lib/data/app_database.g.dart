// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StagesTable extends Stages with TableInfo<$StagesTable, StageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameJa, nameZh, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stages';
  @override
  VerificationContext validateIntegrity(
    Insertable<StageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      ),
    );
  }

  @override
  $StagesTable createAlias(String alias) {
    return $StagesTable(attachedDatabase, alias);
  }
}

class StageRow extends DataClass implements Insertable<StageRow> {
  final String id;
  final String nameJa;
  final String? nameZh;
  final int? sortOrder;
  const StageRow({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || sortOrder != null) {
      map['sort_order'] = Variable<int>(sortOrder);
    }
    return map;
  }

  StagesCompanion toCompanion(bool nullToAbsent) {
    return StagesCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      sortOrder: sortOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(sortOrder),
    );
  }

  factory StageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StageRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      sortOrder: serializer.fromJson<int?>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
      'sortOrder': serializer.toJson<int?>(sortOrder),
    };
  }

  StageRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
    Value<int?> sortOrder = const Value.absent(),
  }) => StageRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    sortOrder: sortOrder.present ? sortOrder.value : this.sortOrder,
  );
  StageRow copyWithCompanion(StagesCompanion data) {
    return StageRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StageRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameJa, nameZh, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StageRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh &&
          other.sortOrder == this.sortOrder);
}

class StagesCompanion extends UpdateCompanion<StageRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<int?> sortOrder;
  final Value<int> rowid;
  const StagesCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StagesCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<StageRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StagesCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<int?>? sortOrder,
    Value<int>? rowid,
  }) {
    return StagesCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StagesCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttributesTable extends Attributes
    with TableInfo<$AttributesTable, AttributeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttributesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameJa, nameZh];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attributes';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttributeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttributeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttributeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
    );
  }

  @override
  $AttributesTable createAlias(String alias) {
    return $AttributesTable(attachedDatabase, alias);
  }
}

class AttributeRow extends DataClass implements Insertable<AttributeRow> {
  final String id;
  final String nameJa;
  final String? nameZh;
  const AttributeRow({required this.id, required this.nameJa, this.nameZh});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    return map;
  }

  AttributesCompanion toCompanion(bool nullToAbsent) {
    return AttributesCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
    );
  }

  factory AttributeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttributeRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
    };
  }

  AttributeRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
  }) => AttributeRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
  );
  AttributeRow copyWithCompanion(AttributesCompanion data) {
    return AttributeRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttributeRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameJa, nameZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttributeRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh);
}

class AttributesCompanion extends UpdateCompanion<AttributeRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<int> rowid;
  const AttributesCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttributesCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<AttributeRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttributesCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<int>? rowid,
  }) {
    return AttributesCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttributesCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TypesTable extends Types with TableInfo<$TypesTable, TypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameJa, nameZh];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'types';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
    );
  }

  @override
  $TypesTable createAlias(String alias) {
    return $TypesTable(attachedDatabase, alias);
  }
}

class TypeRow extends DataClass implements Insertable<TypeRow> {
  final String id;
  final String nameJa;
  final String? nameZh;
  const TypeRow({required this.id, required this.nameJa, this.nameZh});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    return map;
  }

  TypesCompanion toCompanion(bool nullToAbsent) {
    return TypesCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
    );
  }

  factory TypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
    };
  }

  TypeRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
  }) => TypeRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
  );
  TypeRow copyWithCompanion(TypesCompanion data) {
    return TypeRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameJa, nameZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh);
}

class TypesCompanion extends UpdateCompanion<TypeRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<int> rowid;
  const TypesCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypesCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<TypeRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypesCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<int>? rowid,
  }) {
    return TypesCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ElementsTable extends Elements
    with TableInfo<$ElementsTable, ElementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameJa, nameZh];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'elements';
  @override
  VerificationContext validateIntegrity(
    Insertable<ElementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ElementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
    );
  }

  @override
  $ElementsTable createAlias(String alias) {
    return $ElementsTable(attachedDatabase, alias);
  }
}

class ElementRow extends DataClass implements Insertable<ElementRow> {
  final String id;
  final String nameJa;
  final String? nameZh;
  const ElementRow({required this.id, required this.nameJa, this.nameZh});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    return map;
  }

  ElementsCompanion toCompanion(bool nullToAbsent) {
    return ElementsCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
    );
  }

  factory ElementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElementRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
    };
  }

  ElementRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
  }) => ElementRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
  );
  ElementRow copyWithCompanion(ElementsCompanion data) {
    return ElementRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElementRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameJa, nameZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElementRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh);
}

class ElementsCompanion extends UpdateCompanion<ElementRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<int> rowid;
  const ElementsCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ElementsCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<ElementRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ElementsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<int>? rowid,
  }) {
    return ElementsCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElementsCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PersonalitiesTable extends Personalities
    with TableInfo<$PersonalitiesTable, PersonalityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _upStatJaMeta = const VerificationMeta(
    'upStatJa',
  );
  @override
  late final GeneratedColumn<String> upStatJa = GeneratedColumn<String>(
    'up_stat_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _upStatZhMeta = const VerificationMeta(
    'upStatZh',
  );
  @override
  late final GeneratedColumn<String> upStatZh = GeneratedColumn<String>(
    'up_stat_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _downStatJaMeta = const VerificationMeta(
    'downStatJa',
  );
  @override
  late final GeneratedColumn<String> downStatJa = GeneratedColumn<String>(
    'down_stat_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _downStatZhMeta = const VerificationMeta(
    'downStatZh',
  );
  @override
  late final GeneratedColumn<String> downStatZh = GeneratedColumn<String>(
    'down_stat_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionJaMeta = const VerificationMeta(
    'descriptionJa',
  );
  @override
  late final GeneratedColumn<String> descriptionJa = GeneratedColumn<String>(
    'description_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionZhMeta = const VerificationMeta(
    'descriptionZh',
  );
  @override
  late final GeneratedColumn<String> descriptionZh = GeneratedColumn<String>(
    'description_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameJa,
    nameZh,
    upStatJa,
    upStatZh,
    downStatJa,
    downStatZh,
    descriptionJa,
    descriptionZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personalities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('up_stat_ja')) {
      context.handle(
        _upStatJaMeta,
        upStatJa.isAcceptableOrUnknown(data['up_stat_ja']!, _upStatJaMeta),
      );
    }
    if (data.containsKey('up_stat_zh')) {
      context.handle(
        _upStatZhMeta,
        upStatZh.isAcceptableOrUnknown(data['up_stat_zh']!, _upStatZhMeta),
      );
    }
    if (data.containsKey('down_stat_ja')) {
      context.handle(
        _downStatJaMeta,
        downStatJa.isAcceptableOrUnknown(
          data['down_stat_ja']!,
          _downStatJaMeta,
        ),
      );
    }
    if (data.containsKey('down_stat_zh')) {
      context.handle(
        _downStatZhMeta,
        downStatZh.isAcceptableOrUnknown(
          data['down_stat_zh']!,
          _downStatZhMeta,
        ),
      );
    }
    if (data.containsKey('description_ja')) {
      context.handle(
        _descriptionJaMeta,
        descriptionJa.isAcceptableOrUnknown(
          data['description_ja']!,
          _descriptionJaMeta,
        ),
      );
    }
    if (data.containsKey('description_zh')) {
      context.handle(
        _descriptionZhMeta,
        descriptionZh.isAcceptableOrUnknown(
          data['description_zh']!,
          _descriptionZhMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      upStatJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}up_stat_ja'],
      ),
      upStatZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}up_stat_zh'],
      ),
      downStatJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}down_stat_ja'],
      ),
      downStatZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}down_stat_zh'],
      ),
      descriptionJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ja'],
      ),
      descriptionZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_zh'],
      ),
    );
  }

  @override
  $PersonalitiesTable createAlias(String alias) {
    return $PersonalitiesTable(attachedDatabase, alias);
  }
}

class PersonalityRow extends DataClass implements Insertable<PersonalityRow> {
  final String id;
  final String nameJa;
  final String? nameZh;

  /// 對應上升的能力（例：「攻撃力上昇」）。
  final String? upStatJa;
  final String? upStatZh;

  /// 對應下降的能力。
  final String? downStatJa;
  final String? downStatZh;
  final String? descriptionJa;
  final String? descriptionZh;
  const PersonalityRow({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.upStatJa,
    this.upStatZh,
    this.downStatJa,
    this.downStatZh,
    this.descriptionJa,
    this.descriptionZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || upStatJa != null) {
      map['up_stat_ja'] = Variable<String>(upStatJa);
    }
    if (!nullToAbsent || upStatZh != null) {
      map['up_stat_zh'] = Variable<String>(upStatZh);
    }
    if (!nullToAbsent || downStatJa != null) {
      map['down_stat_ja'] = Variable<String>(downStatJa);
    }
    if (!nullToAbsent || downStatZh != null) {
      map['down_stat_zh'] = Variable<String>(downStatZh);
    }
    if (!nullToAbsent || descriptionJa != null) {
      map['description_ja'] = Variable<String>(descriptionJa);
    }
    if (!nullToAbsent || descriptionZh != null) {
      map['description_zh'] = Variable<String>(descriptionZh);
    }
    return map;
  }

  PersonalitiesCompanion toCompanion(bool nullToAbsent) {
    return PersonalitiesCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      upStatJa: upStatJa == null && nullToAbsent
          ? const Value.absent()
          : Value(upStatJa),
      upStatZh: upStatZh == null && nullToAbsent
          ? const Value.absent()
          : Value(upStatZh),
      downStatJa: downStatJa == null && nullToAbsent
          ? const Value.absent()
          : Value(downStatJa),
      downStatZh: downStatZh == null && nullToAbsent
          ? const Value.absent()
          : Value(downStatZh),
      descriptionJa: descriptionJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionJa),
      descriptionZh: descriptionZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionZh),
    );
  }

  factory PersonalityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalityRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      upStatJa: serializer.fromJson<String?>(json['upStatJa']),
      upStatZh: serializer.fromJson<String?>(json['upStatZh']),
      downStatJa: serializer.fromJson<String?>(json['downStatJa']),
      downStatZh: serializer.fromJson<String?>(json['downStatZh']),
      descriptionJa: serializer.fromJson<String?>(json['descriptionJa']),
      descriptionZh: serializer.fromJson<String?>(json['descriptionZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
      'upStatJa': serializer.toJson<String?>(upStatJa),
      'upStatZh': serializer.toJson<String?>(upStatZh),
      'downStatJa': serializer.toJson<String?>(downStatJa),
      'downStatZh': serializer.toJson<String?>(downStatZh),
      'descriptionJa': serializer.toJson<String?>(descriptionJa),
      'descriptionZh': serializer.toJson<String?>(descriptionZh),
    };
  }

  PersonalityRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
    Value<String?> upStatJa = const Value.absent(),
    Value<String?> upStatZh = const Value.absent(),
    Value<String?> downStatJa = const Value.absent(),
    Value<String?> downStatZh = const Value.absent(),
    Value<String?> descriptionJa = const Value.absent(),
    Value<String?> descriptionZh = const Value.absent(),
  }) => PersonalityRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    upStatJa: upStatJa.present ? upStatJa.value : this.upStatJa,
    upStatZh: upStatZh.present ? upStatZh.value : this.upStatZh,
    downStatJa: downStatJa.present ? downStatJa.value : this.downStatJa,
    downStatZh: downStatZh.present ? downStatZh.value : this.downStatZh,
    descriptionJa: descriptionJa.present
        ? descriptionJa.value
        : this.descriptionJa,
    descriptionZh: descriptionZh.present
        ? descriptionZh.value
        : this.descriptionZh,
  );
  PersonalityRow copyWithCompanion(PersonalitiesCompanion data) {
    return PersonalityRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      upStatJa: data.upStatJa.present ? data.upStatJa.value : this.upStatJa,
      upStatZh: data.upStatZh.present ? data.upStatZh.value : this.upStatZh,
      downStatJa: data.downStatJa.present
          ? data.downStatJa.value
          : this.downStatJa,
      downStatZh: data.downStatZh.present
          ? data.downStatZh.value
          : this.downStatZh,
      descriptionJa: data.descriptionJa.present
          ? data.descriptionJa.value
          : this.descriptionJa,
      descriptionZh: data.descriptionZh.present
          ? data.descriptionZh.value
          : this.descriptionZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalityRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('upStatJa: $upStatJa, ')
          ..write('upStatZh: $upStatZh, ')
          ..write('downStatJa: $downStatJa, ')
          ..write('downStatZh: $downStatZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameJa,
    nameZh,
    upStatJa,
    upStatZh,
    downStatJa,
    downStatZh,
    descriptionJa,
    descriptionZh,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalityRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh &&
          other.upStatJa == this.upStatJa &&
          other.upStatZh == this.upStatZh &&
          other.downStatJa == this.downStatJa &&
          other.downStatZh == this.downStatZh &&
          other.descriptionJa == this.descriptionJa &&
          other.descriptionZh == this.descriptionZh);
}

class PersonalitiesCompanion extends UpdateCompanion<PersonalityRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<String?> upStatJa;
  final Value<String?> upStatZh;
  final Value<String?> downStatJa;
  final Value<String?> downStatZh;
  final Value<String?> descriptionJa;
  final Value<String?> descriptionZh;
  final Value<int> rowid;
  const PersonalitiesCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.upStatJa = const Value.absent(),
    this.upStatZh = const Value.absent(),
    this.downStatJa = const Value.absent(),
    this.downStatZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonalitiesCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.upStatJa = const Value.absent(),
    this.upStatZh = const Value.absent(),
    this.downStatJa = const Value.absent(),
    this.downStatZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<PersonalityRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<String>? upStatJa,
    Expression<String>? upStatZh,
    Expression<String>? downStatJa,
    Expression<String>? downStatZh,
    Expression<String>? descriptionJa,
    Expression<String>? descriptionZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (upStatJa != null) 'up_stat_ja': upStatJa,
      if (upStatZh != null) 'up_stat_zh': upStatZh,
      if (downStatJa != null) 'down_stat_ja': downStatJa,
      if (downStatZh != null) 'down_stat_zh': downStatZh,
      if (descriptionJa != null) 'description_ja': descriptionJa,
      if (descriptionZh != null) 'description_zh': descriptionZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonalitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<String?>? upStatJa,
    Value<String?>? upStatZh,
    Value<String?>? downStatJa,
    Value<String?>? downStatZh,
    Value<String?>? descriptionJa,
    Value<String?>? descriptionZh,
    Value<int>? rowid,
  }) {
    return PersonalitiesCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      upStatJa: upStatJa ?? this.upStatJa,
      upStatZh: upStatZh ?? this.upStatZh,
      downStatJa: downStatJa ?? this.downStatJa,
      downStatZh: downStatZh ?? this.downStatZh,
      descriptionJa: descriptionJa ?? this.descriptionJa,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (upStatJa.present) {
      map['up_stat_ja'] = Variable<String>(upStatJa.value);
    }
    if (upStatZh.present) {
      map['up_stat_zh'] = Variable<String>(upStatZh.value);
    }
    if (downStatJa.present) {
      map['down_stat_ja'] = Variable<String>(downStatJa.value);
    }
    if (downStatZh.present) {
      map['down_stat_zh'] = Variable<String>(downStatZh.value);
    }
    if (descriptionJa.present) {
      map['description_ja'] = Variable<String>(descriptionJa.value);
    }
    if (descriptionZh.present) {
      map['description_zh'] = Variable<String>(descriptionZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalitiesCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('upStatJa: $upStatJa, ')
          ..write('upStatZh: $upStatZh, ')
          ..write('downStatJa: $downStatJa, ')
          ..write('downStatZh: $downStatZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DigimonsTable extends Digimons
    with TableInfo<$DigimonsTable, DigimonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DigimonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dexNumberMeta = const VerificationMeta(
    'dexNumber',
  );
  @override
  late final GeneratedColumn<int> dexNumber = GeneratedColumn<int>(
    'dex_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stageIdMeta = const VerificationMeta(
    'stageId',
  );
  @override
  late final GeneratedColumn<String> stageId = GeneratedColumn<String>(
    'stage_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stages (id)',
    ),
  );
  static const VerificationMeta _attributeIdMeta = const VerificationMeta(
    'attributeId',
  );
  @override
  late final GeneratedColumn<String> attributeId = GeneratedColumn<String>(
    'attribute_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES attributes (id)',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<String> typeId = GeneratedColumn<String>(
    'type_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id)',
    ),
  );
  static const VerificationMeta _elementIdMeta = const VerificationMeta(
    'elementId',
  );
  @override
  late final GeneratedColumn<String> elementId = GeneratedColumn<String>(
    'element_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES elements (id)',
    ),
  );
  static const VerificationMeta _personalityIdMeta = const VerificationMeta(
    'personalityId',
  );
  @override
  late final GeneratedColumn<String> personalityId = GeneratedColumn<String>(
    'personality_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES personalities (id)',
    ),
  );
  static const VerificationMeta _canDigirideMeta = const VerificationMeta(
    'canDigiride',
  );
  @override
  late final GeneratedColumn<bool> canDigiride = GeneratedColumn<bool>(
    'can_digiride',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_digiride" IN (0, 1))',
    ),
  );
  static const VerificationMeta _dlcPackMeta = const VerificationMeta(
    'dlcPack',
  );
  @override
  late final GeneratedColumn<String> dlcPack = GeneratedColumn<String>(
    'dlc_pack',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxHpMeta = const VerificationMeta('maxHp');
  @override
  late final GeneratedColumn<int> maxHp = GeneratedColumn<int>(
    'max_hp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxSpMeta = const VerificationMeta('maxSp');
  @override
  late final GeneratedColumn<int> maxSp = GeneratedColumn<int>(
    'max_sp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxAtkMeta = const VerificationMeta('maxAtk');
  @override
  late final GeneratedColumn<int> maxAtk = GeneratedColumn<int>(
    'max_atk',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxDefMeta = const VerificationMeta('maxDef');
  @override
  late final GeneratedColumn<int> maxDef = GeneratedColumn<int>(
    'max_def',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxIntMeta = const VerificationMeta('maxInt');
  @override
  late final GeneratedColumn<int> maxInt = GeneratedColumn<int>(
    'max_int',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxMenMeta = const VerificationMeta('maxMen');
  @override
  late final GeneratedColumn<int> maxMen = GeneratedColumn<int>(
    'max_men',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxSpdMeta = const VerificationMeta('maxSpd');
  @override
  late final GeneratedColumn<int> maxSpd = GeneratedColumn<int>(
    'max_spd',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceUrlJaMeta = const VerificationMeta(
    'sourceUrlJa',
  );
  @override
  late final GeneratedColumn<String> sourceUrlJa = GeneratedColumn<String>(
    'source_url_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceUrlZhMeta = const VerificationMeta(
    'sourceUrlZh',
  );
  @override
  late final GeneratedColumn<String> sourceUrlZh = GeneratedColumn<String>(
    'source_url_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionJaMeta = const VerificationMeta(
    'descriptionJa',
  );
  @override
  late final GeneratedColumn<String> descriptionJa = GeneratedColumn<String>(
    'description_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionZhMeta = const VerificationMeta(
    'descriptionZh',
  );
  @override
  late final GeneratedColumn<String> descriptionZh = GeneratedColumn<String>(
    'description_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dexNumber,
    nameJa,
    nameZh,
    nameEn,
    stageId,
    attributeId,
    typeId,
    elementId,
    personalityId,
    canDigiride,
    dlcPack,
    maxHp,
    maxSp,
    maxAtk,
    maxDef,
    maxInt,
    maxMen,
    maxSpd,
    imagePath,
    sourceUrlJa,
    sourceUrlZh,
    descriptionJa,
    descriptionZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'digimons';
  @override
  VerificationContext validateIntegrity(
    Insertable<DigimonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('dex_number')) {
      context.handle(
        _dexNumberMeta,
        dexNumber.isAcceptableOrUnknown(data['dex_number']!, _dexNumberMeta),
      );
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('stage_id')) {
      context.handle(
        _stageIdMeta,
        stageId.isAcceptableOrUnknown(data['stage_id']!, _stageIdMeta),
      );
    }
    if (data.containsKey('attribute_id')) {
      context.handle(
        _attributeIdMeta,
        attributeId.isAcceptableOrUnknown(
          data['attribute_id']!,
          _attributeIdMeta,
        ),
      );
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    }
    if (data.containsKey('element_id')) {
      context.handle(
        _elementIdMeta,
        elementId.isAcceptableOrUnknown(data['element_id']!, _elementIdMeta),
      );
    }
    if (data.containsKey('personality_id')) {
      context.handle(
        _personalityIdMeta,
        personalityId.isAcceptableOrUnknown(
          data['personality_id']!,
          _personalityIdMeta,
        ),
      );
    }
    if (data.containsKey('can_digiride')) {
      context.handle(
        _canDigirideMeta,
        canDigiride.isAcceptableOrUnknown(
          data['can_digiride']!,
          _canDigirideMeta,
        ),
      );
    }
    if (data.containsKey('dlc_pack')) {
      context.handle(
        _dlcPackMeta,
        dlcPack.isAcceptableOrUnknown(data['dlc_pack']!, _dlcPackMeta),
      );
    }
    if (data.containsKey('max_hp')) {
      context.handle(
        _maxHpMeta,
        maxHp.isAcceptableOrUnknown(data['max_hp']!, _maxHpMeta),
      );
    }
    if (data.containsKey('max_sp')) {
      context.handle(
        _maxSpMeta,
        maxSp.isAcceptableOrUnknown(data['max_sp']!, _maxSpMeta),
      );
    }
    if (data.containsKey('max_atk')) {
      context.handle(
        _maxAtkMeta,
        maxAtk.isAcceptableOrUnknown(data['max_atk']!, _maxAtkMeta),
      );
    }
    if (data.containsKey('max_def')) {
      context.handle(
        _maxDefMeta,
        maxDef.isAcceptableOrUnknown(data['max_def']!, _maxDefMeta),
      );
    }
    if (data.containsKey('max_int')) {
      context.handle(
        _maxIntMeta,
        maxInt.isAcceptableOrUnknown(data['max_int']!, _maxIntMeta),
      );
    }
    if (data.containsKey('max_men')) {
      context.handle(
        _maxMenMeta,
        maxMen.isAcceptableOrUnknown(data['max_men']!, _maxMenMeta),
      );
    }
    if (data.containsKey('max_spd')) {
      context.handle(
        _maxSpdMeta,
        maxSpd.isAcceptableOrUnknown(data['max_spd']!, _maxSpdMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('source_url_ja')) {
      context.handle(
        _sourceUrlJaMeta,
        sourceUrlJa.isAcceptableOrUnknown(
          data['source_url_ja']!,
          _sourceUrlJaMeta,
        ),
      );
    }
    if (data.containsKey('source_url_zh')) {
      context.handle(
        _sourceUrlZhMeta,
        sourceUrlZh.isAcceptableOrUnknown(
          data['source_url_zh']!,
          _sourceUrlZhMeta,
        ),
      );
    }
    if (data.containsKey('description_ja')) {
      context.handle(
        _descriptionJaMeta,
        descriptionJa.isAcceptableOrUnknown(
          data['description_ja']!,
          _descriptionJaMeta,
        ),
      );
    }
    if (data.containsKey('description_zh')) {
      context.handle(
        _descriptionZhMeta,
        descriptionZh.isAcceptableOrUnknown(
          data['description_zh']!,
          _descriptionZhMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DigimonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DigimonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dexNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dex_number'],
      ),
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      stageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage_id'],
      ),
      attributeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attribute_id'],
      ),
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_id'],
      ),
      elementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}element_id'],
      ),
      personalityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personality_id'],
      ),
      canDigiride: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_digiride'],
      ),
      dlcPack: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dlc_pack'],
      ),
      maxHp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_hp'],
      ),
      maxSp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_sp'],
      ),
      maxAtk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_atk'],
      ),
      maxDef: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_def'],
      ),
      maxInt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_int'],
      ),
      maxMen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_men'],
      ),
      maxSpd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_spd'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      sourceUrlJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url_ja'],
      ),
      sourceUrlZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url_zh'],
      ),
      descriptionJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ja'],
      ),
      descriptionZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_zh'],
      ),
    );
  }

  @override
  $DigimonsTable createAlias(String alias) {
    return $DigimonsTable(attachedDatabase, alias);
  }
}

class DigimonRow extends DataClass implements Insertable<DigimonRow> {
  /// 內部 slug（英文，做為穩定識別碼，例如 'agumon'）。
  final String id;

  /// 圖鑑編號（遊戲內 No.）。
  final int? dexNumber;

  /// 名稱（日 / 中 / 英）。
  final String nameJa;
  final String? nameZh;
  final String? nameEn;

  /// 世代（FK -> stages）。
  final String? stageId;

  /// 種族屬性（FK -> attributes，例 'no_data' / 'data' / 'vaccine' / 'virus' / 'free'）。
  final String? attributeId;

  /// 種族類型（FK -> types）。
  final String? typeId;

  /// 属性（FK -> elements）。
  final String? elementId;

  /// 基本性格（FK -> personalities）。
  final String? personalityId;

  /// 是否可作為デジライド（搭乘）對象。
  final bool? canDigiride;

  /// DLC 來源（NULL = 本體；例：'Alternate Dimension'）。
  final String? dlcPack;

  /// Lv99 + エージェントスキル全 MAX 狀態下的能力值。
  final int? maxHp;
  final int? maxSp;
  final int? maxAtk;
  final int? maxDef;
  final int? maxInt;
  final int? maxMen;
  final int? maxSpd;

  /// 圖片路徑（user data 相對路徑，例：images/digimon/agumon.png）。
  final String? imagePath;

  /// 來源 URL（用於除錯/再爬取）。
  final String? sourceUrlJa;
  final String? sourceUrlZh;

  /// 自由文本備註（簡介、技能特性等）。
  final String? descriptionJa;
  final String? descriptionZh;
  const DigimonRow({
    required this.id,
    this.dexNumber,
    required this.nameJa,
    this.nameZh,
    this.nameEn,
    this.stageId,
    this.attributeId,
    this.typeId,
    this.elementId,
    this.personalityId,
    this.canDigiride,
    this.dlcPack,
    this.maxHp,
    this.maxSp,
    this.maxAtk,
    this.maxDef,
    this.maxInt,
    this.maxMen,
    this.maxSpd,
    this.imagePath,
    this.sourceUrlJa,
    this.sourceUrlZh,
    this.descriptionJa,
    this.descriptionZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || dexNumber != null) {
      map['dex_number'] = Variable<int>(dexNumber);
    }
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || stageId != null) {
      map['stage_id'] = Variable<String>(stageId);
    }
    if (!nullToAbsent || attributeId != null) {
      map['attribute_id'] = Variable<String>(attributeId);
    }
    if (!nullToAbsent || typeId != null) {
      map['type_id'] = Variable<String>(typeId);
    }
    if (!nullToAbsent || elementId != null) {
      map['element_id'] = Variable<String>(elementId);
    }
    if (!nullToAbsent || personalityId != null) {
      map['personality_id'] = Variable<String>(personalityId);
    }
    if (!nullToAbsent || canDigiride != null) {
      map['can_digiride'] = Variable<bool>(canDigiride);
    }
    if (!nullToAbsent || dlcPack != null) {
      map['dlc_pack'] = Variable<String>(dlcPack);
    }
    if (!nullToAbsent || maxHp != null) {
      map['max_hp'] = Variable<int>(maxHp);
    }
    if (!nullToAbsent || maxSp != null) {
      map['max_sp'] = Variable<int>(maxSp);
    }
    if (!nullToAbsent || maxAtk != null) {
      map['max_atk'] = Variable<int>(maxAtk);
    }
    if (!nullToAbsent || maxDef != null) {
      map['max_def'] = Variable<int>(maxDef);
    }
    if (!nullToAbsent || maxInt != null) {
      map['max_int'] = Variable<int>(maxInt);
    }
    if (!nullToAbsent || maxMen != null) {
      map['max_men'] = Variable<int>(maxMen);
    }
    if (!nullToAbsent || maxSpd != null) {
      map['max_spd'] = Variable<int>(maxSpd);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || sourceUrlJa != null) {
      map['source_url_ja'] = Variable<String>(sourceUrlJa);
    }
    if (!nullToAbsent || sourceUrlZh != null) {
      map['source_url_zh'] = Variable<String>(sourceUrlZh);
    }
    if (!nullToAbsent || descriptionJa != null) {
      map['description_ja'] = Variable<String>(descriptionJa);
    }
    if (!nullToAbsent || descriptionZh != null) {
      map['description_zh'] = Variable<String>(descriptionZh);
    }
    return map;
  }

  DigimonsCompanion toCompanion(bool nullToAbsent) {
    return DigimonsCompanion(
      id: Value(id),
      dexNumber: dexNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(dexNumber),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      stageId: stageId == null && nullToAbsent
          ? const Value.absent()
          : Value(stageId),
      attributeId: attributeId == null && nullToAbsent
          ? const Value.absent()
          : Value(attributeId),
      typeId: typeId == null && nullToAbsent
          ? const Value.absent()
          : Value(typeId),
      elementId: elementId == null && nullToAbsent
          ? const Value.absent()
          : Value(elementId),
      personalityId: personalityId == null && nullToAbsent
          ? const Value.absent()
          : Value(personalityId),
      canDigiride: canDigiride == null && nullToAbsent
          ? const Value.absent()
          : Value(canDigiride),
      dlcPack: dlcPack == null && nullToAbsent
          ? const Value.absent()
          : Value(dlcPack),
      maxHp: maxHp == null && nullToAbsent
          ? const Value.absent()
          : Value(maxHp),
      maxSp: maxSp == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSp),
      maxAtk: maxAtk == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAtk),
      maxDef: maxDef == null && nullToAbsent
          ? const Value.absent()
          : Value(maxDef),
      maxInt: maxInt == null && nullToAbsent
          ? const Value.absent()
          : Value(maxInt),
      maxMen: maxMen == null && nullToAbsent
          ? const Value.absent()
          : Value(maxMen),
      maxSpd: maxSpd == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSpd),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      sourceUrlJa: sourceUrlJa == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrlJa),
      sourceUrlZh: sourceUrlZh == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrlZh),
      descriptionJa: descriptionJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionJa),
      descriptionZh: descriptionZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionZh),
    );
  }

  factory DigimonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DigimonRow(
      id: serializer.fromJson<String>(json['id']),
      dexNumber: serializer.fromJson<int?>(json['dexNumber']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      stageId: serializer.fromJson<String?>(json['stageId']),
      attributeId: serializer.fromJson<String?>(json['attributeId']),
      typeId: serializer.fromJson<String?>(json['typeId']),
      elementId: serializer.fromJson<String?>(json['elementId']),
      personalityId: serializer.fromJson<String?>(json['personalityId']),
      canDigiride: serializer.fromJson<bool?>(json['canDigiride']),
      dlcPack: serializer.fromJson<String?>(json['dlcPack']),
      maxHp: serializer.fromJson<int?>(json['maxHp']),
      maxSp: serializer.fromJson<int?>(json['maxSp']),
      maxAtk: serializer.fromJson<int?>(json['maxAtk']),
      maxDef: serializer.fromJson<int?>(json['maxDef']),
      maxInt: serializer.fromJson<int?>(json['maxInt']),
      maxMen: serializer.fromJson<int?>(json['maxMen']),
      maxSpd: serializer.fromJson<int?>(json['maxSpd']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      sourceUrlJa: serializer.fromJson<String?>(json['sourceUrlJa']),
      sourceUrlZh: serializer.fromJson<String?>(json['sourceUrlZh']),
      descriptionJa: serializer.fromJson<String?>(json['descriptionJa']),
      descriptionZh: serializer.fromJson<String?>(json['descriptionZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dexNumber': serializer.toJson<int?>(dexNumber),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
      'nameEn': serializer.toJson<String?>(nameEn),
      'stageId': serializer.toJson<String?>(stageId),
      'attributeId': serializer.toJson<String?>(attributeId),
      'typeId': serializer.toJson<String?>(typeId),
      'elementId': serializer.toJson<String?>(elementId),
      'personalityId': serializer.toJson<String?>(personalityId),
      'canDigiride': serializer.toJson<bool?>(canDigiride),
      'dlcPack': serializer.toJson<String?>(dlcPack),
      'maxHp': serializer.toJson<int?>(maxHp),
      'maxSp': serializer.toJson<int?>(maxSp),
      'maxAtk': serializer.toJson<int?>(maxAtk),
      'maxDef': serializer.toJson<int?>(maxDef),
      'maxInt': serializer.toJson<int?>(maxInt),
      'maxMen': serializer.toJson<int?>(maxMen),
      'maxSpd': serializer.toJson<int?>(maxSpd),
      'imagePath': serializer.toJson<String?>(imagePath),
      'sourceUrlJa': serializer.toJson<String?>(sourceUrlJa),
      'sourceUrlZh': serializer.toJson<String?>(sourceUrlZh),
      'descriptionJa': serializer.toJson<String?>(descriptionJa),
      'descriptionZh': serializer.toJson<String?>(descriptionZh),
    };
  }

  DigimonRow copyWith({
    String? id,
    Value<int?> dexNumber = const Value.absent(),
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    Value<String?> stageId = const Value.absent(),
    Value<String?> attributeId = const Value.absent(),
    Value<String?> typeId = const Value.absent(),
    Value<String?> elementId = const Value.absent(),
    Value<String?> personalityId = const Value.absent(),
    Value<bool?> canDigiride = const Value.absent(),
    Value<String?> dlcPack = const Value.absent(),
    Value<int?> maxHp = const Value.absent(),
    Value<int?> maxSp = const Value.absent(),
    Value<int?> maxAtk = const Value.absent(),
    Value<int?> maxDef = const Value.absent(),
    Value<int?> maxInt = const Value.absent(),
    Value<int?> maxMen = const Value.absent(),
    Value<int?> maxSpd = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    Value<String?> sourceUrlJa = const Value.absent(),
    Value<String?> sourceUrlZh = const Value.absent(),
    Value<String?> descriptionJa = const Value.absent(),
    Value<String?> descriptionZh = const Value.absent(),
  }) => DigimonRow(
    id: id ?? this.id,
    dexNumber: dexNumber.present ? dexNumber.value : this.dexNumber,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    stageId: stageId.present ? stageId.value : this.stageId,
    attributeId: attributeId.present ? attributeId.value : this.attributeId,
    typeId: typeId.present ? typeId.value : this.typeId,
    elementId: elementId.present ? elementId.value : this.elementId,
    personalityId: personalityId.present
        ? personalityId.value
        : this.personalityId,
    canDigiride: canDigiride.present ? canDigiride.value : this.canDigiride,
    dlcPack: dlcPack.present ? dlcPack.value : this.dlcPack,
    maxHp: maxHp.present ? maxHp.value : this.maxHp,
    maxSp: maxSp.present ? maxSp.value : this.maxSp,
    maxAtk: maxAtk.present ? maxAtk.value : this.maxAtk,
    maxDef: maxDef.present ? maxDef.value : this.maxDef,
    maxInt: maxInt.present ? maxInt.value : this.maxInt,
    maxMen: maxMen.present ? maxMen.value : this.maxMen,
    maxSpd: maxSpd.present ? maxSpd.value : this.maxSpd,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    sourceUrlJa: sourceUrlJa.present ? sourceUrlJa.value : this.sourceUrlJa,
    sourceUrlZh: sourceUrlZh.present ? sourceUrlZh.value : this.sourceUrlZh,
    descriptionJa: descriptionJa.present
        ? descriptionJa.value
        : this.descriptionJa,
    descriptionZh: descriptionZh.present
        ? descriptionZh.value
        : this.descriptionZh,
  );
  DigimonRow copyWithCompanion(DigimonsCompanion data) {
    return DigimonRow(
      id: data.id.present ? data.id.value : this.id,
      dexNumber: data.dexNumber.present ? data.dexNumber.value : this.dexNumber,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      stageId: data.stageId.present ? data.stageId.value : this.stageId,
      attributeId: data.attributeId.present
          ? data.attributeId.value
          : this.attributeId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      elementId: data.elementId.present ? data.elementId.value : this.elementId,
      personalityId: data.personalityId.present
          ? data.personalityId.value
          : this.personalityId,
      canDigiride: data.canDigiride.present
          ? data.canDigiride.value
          : this.canDigiride,
      dlcPack: data.dlcPack.present ? data.dlcPack.value : this.dlcPack,
      maxHp: data.maxHp.present ? data.maxHp.value : this.maxHp,
      maxSp: data.maxSp.present ? data.maxSp.value : this.maxSp,
      maxAtk: data.maxAtk.present ? data.maxAtk.value : this.maxAtk,
      maxDef: data.maxDef.present ? data.maxDef.value : this.maxDef,
      maxInt: data.maxInt.present ? data.maxInt.value : this.maxInt,
      maxMen: data.maxMen.present ? data.maxMen.value : this.maxMen,
      maxSpd: data.maxSpd.present ? data.maxSpd.value : this.maxSpd,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      sourceUrlJa: data.sourceUrlJa.present
          ? data.sourceUrlJa.value
          : this.sourceUrlJa,
      sourceUrlZh: data.sourceUrlZh.present
          ? data.sourceUrlZh.value
          : this.sourceUrlZh,
      descriptionJa: data.descriptionJa.present
          ? data.descriptionJa.value
          : this.descriptionJa,
      descriptionZh: data.descriptionZh.present
          ? data.descriptionZh.value
          : this.descriptionZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DigimonRow(')
          ..write('id: $id, ')
          ..write('dexNumber: $dexNumber, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('nameEn: $nameEn, ')
          ..write('stageId: $stageId, ')
          ..write('attributeId: $attributeId, ')
          ..write('typeId: $typeId, ')
          ..write('elementId: $elementId, ')
          ..write('personalityId: $personalityId, ')
          ..write('canDigiride: $canDigiride, ')
          ..write('dlcPack: $dlcPack, ')
          ..write('maxHp: $maxHp, ')
          ..write('maxSp: $maxSp, ')
          ..write('maxAtk: $maxAtk, ')
          ..write('maxDef: $maxDef, ')
          ..write('maxInt: $maxInt, ')
          ..write('maxMen: $maxMen, ')
          ..write('maxSpd: $maxSpd, ')
          ..write('imagePath: $imagePath, ')
          ..write('sourceUrlJa: $sourceUrlJa, ')
          ..write('sourceUrlZh: $sourceUrlZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    dexNumber,
    nameJa,
    nameZh,
    nameEn,
    stageId,
    attributeId,
    typeId,
    elementId,
    personalityId,
    canDigiride,
    dlcPack,
    maxHp,
    maxSp,
    maxAtk,
    maxDef,
    maxInt,
    maxMen,
    maxSpd,
    imagePath,
    sourceUrlJa,
    sourceUrlZh,
    descriptionJa,
    descriptionZh,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DigimonRow &&
          other.id == this.id &&
          other.dexNumber == this.dexNumber &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh &&
          other.nameEn == this.nameEn &&
          other.stageId == this.stageId &&
          other.attributeId == this.attributeId &&
          other.typeId == this.typeId &&
          other.elementId == this.elementId &&
          other.personalityId == this.personalityId &&
          other.canDigiride == this.canDigiride &&
          other.dlcPack == this.dlcPack &&
          other.maxHp == this.maxHp &&
          other.maxSp == this.maxSp &&
          other.maxAtk == this.maxAtk &&
          other.maxDef == this.maxDef &&
          other.maxInt == this.maxInt &&
          other.maxMen == this.maxMen &&
          other.maxSpd == this.maxSpd &&
          other.imagePath == this.imagePath &&
          other.sourceUrlJa == this.sourceUrlJa &&
          other.sourceUrlZh == this.sourceUrlZh &&
          other.descriptionJa == this.descriptionJa &&
          other.descriptionZh == this.descriptionZh);
}

class DigimonsCompanion extends UpdateCompanion<DigimonRow> {
  final Value<String> id;
  final Value<int?> dexNumber;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<String?> nameEn;
  final Value<String?> stageId;
  final Value<String?> attributeId;
  final Value<String?> typeId;
  final Value<String?> elementId;
  final Value<String?> personalityId;
  final Value<bool?> canDigiride;
  final Value<String?> dlcPack;
  final Value<int?> maxHp;
  final Value<int?> maxSp;
  final Value<int?> maxAtk;
  final Value<int?> maxDef;
  final Value<int?> maxInt;
  final Value<int?> maxMen;
  final Value<int?> maxSpd;
  final Value<String?> imagePath;
  final Value<String?> sourceUrlJa;
  final Value<String?> sourceUrlZh;
  final Value<String?> descriptionJa;
  final Value<String?> descriptionZh;
  final Value<int> rowid;
  const DigimonsCompanion({
    this.id = const Value.absent(),
    this.dexNumber = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.stageId = const Value.absent(),
    this.attributeId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.elementId = const Value.absent(),
    this.personalityId = const Value.absent(),
    this.canDigiride = const Value.absent(),
    this.dlcPack = const Value.absent(),
    this.maxHp = const Value.absent(),
    this.maxSp = const Value.absent(),
    this.maxAtk = const Value.absent(),
    this.maxDef = const Value.absent(),
    this.maxInt = const Value.absent(),
    this.maxMen = const Value.absent(),
    this.maxSpd = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.sourceUrlJa = const Value.absent(),
    this.sourceUrlZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DigimonsCompanion.insert({
    required String id,
    this.dexNumber = const Value.absent(),
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.stageId = const Value.absent(),
    this.attributeId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.elementId = const Value.absent(),
    this.personalityId = const Value.absent(),
    this.canDigiride = const Value.absent(),
    this.dlcPack = const Value.absent(),
    this.maxHp = const Value.absent(),
    this.maxSp = const Value.absent(),
    this.maxAtk = const Value.absent(),
    this.maxDef = const Value.absent(),
    this.maxInt = const Value.absent(),
    this.maxMen = const Value.absent(),
    this.maxSpd = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.sourceUrlJa = const Value.absent(),
    this.sourceUrlZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<DigimonRow> custom({
    Expression<String>? id,
    Expression<int>? dexNumber,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<String>? nameEn,
    Expression<String>? stageId,
    Expression<String>? attributeId,
    Expression<String>? typeId,
    Expression<String>? elementId,
    Expression<String>? personalityId,
    Expression<bool>? canDigiride,
    Expression<String>? dlcPack,
    Expression<int>? maxHp,
    Expression<int>? maxSp,
    Expression<int>? maxAtk,
    Expression<int>? maxDef,
    Expression<int>? maxInt,
    Expression<int>? maxMen,
    Expression<int>? maxSpd,
    Expression<String>? imagePath,
    Expression<String>? sourceUrlJa,
    Expression<String>? sourceUrlZh,
    Expression<String>? descriptionJa,
    Expression<String>? descriptionZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dexNumber != null) 'dex_number': dexNumber,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (nameEn != null) 'name_en': nameEn,
      if (stageId != null) 'stage_id': stageId,
      if (attributeId != null) 'attribute_id': attributeId,
      if (typeId != null) 'type_id': typeId,
      if (elementId != null) 'element_id': elementId,
      if (personalityId != null) 'personality_id': personalityId,
      if (canDigiride != null) 'can_digiride': canDigiride,
      if (dlcPack != null) 'dlc_pack': dlcPack,
      if (maxHp != null) 'max_hp': maxHp,
      if (maxSp != null) 'max_sp': maxSp,
      if (maxAtk != null) 'max_atk': maxAtk,
      if (maxDef != null) 'max_def': maxDef,
      if (maxInt != null) 'max_int': maxInt,
      if (maxMen != null) 'max_men': maxMen,
      if (maxSpd != null) 'max_spd': maxSpd,
      if (imagePath != null) 'image_path': imagePath,
      if (sourceUrlJa != null) 'source_url_ja': sourceUrlJa,
      if (sourceUrlZh != null) 'source_url_zh': sourceUrlZh,
      if (descriptionJa != null) 'description_ja': descriptionJa,
      if (descriptionZh != null) 'description_zh': descriptionZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DigimonsCompanion copyWith({
    Value<String>? id,
    Value<int?>? dexNumber,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<String?>? nameEn,
    Value<String?>? stageId,
    Value<String?>? attributeId,
    Value<String?>? typeId,
    Value<String?>? elementId,
    Value<String?>? personalityId,
    Value<bool?>? canDigiride,
    Value<String?>? dlcPack,
    Value<int?>? maxHp,
    Value<int?>? maxSp,
    Value<int?>? maxAtk,
    Value<int?>? maxDef,
    Value<int?>? maxInt,
    Value<int?>? maxMen,
    Value<int?>? maxSpd,
    Value<String?>? imagePath,
    Value<String?>? sourceUrlJa,
    Value<String?>? sourceUrlZh,
    Value<String?>? descriptionJa,
    Value<String?>? descriptionZh,
    Value<int>? rowid,
  }) {
    return DigimonsCompanion(
      id: id ?? this.id,
      dexNumber: dexNumber ?? this.dexNumber,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      nameEn: nameEn ?? this.nameEn,
      stageId: stageId ?? this.stageId,
      attributeId: attributeId ?? this.attributeId,
      typeId: typeId ?? this.typeId,
      elementId: elementId ?? this.elementId,
      personalityId: personalityId ?? this.personalityId,
      canDigiride: canDigiride ?? this.canDigiride,
      dlcPack: dlcPack ?? this.dlcPack,
      maxHp: maxHp ?? this.maxHp,
      maxSp: maxSp ?? this.maxSp,
      maxAtk: maxAtk ?? this.maxAtk,
      maxDef: maxDef ?? this.maxDef,
      maxInt: maxInt ?? this.maxInt,
      maxMen: maxMen ?? this.maxMen,
      maxSpd: maxSpd ?? this.maxSpd,
      imagePath: imagePath ?? this.imagePath,
      sourceUrlJa: sourceUrlJa ?? this.sourceUrlJa,
      sourceUrlZh: sourceUrlZh ?? this.sourceUrlZh,
      descriptionJa: descriptionJa ?? this.descriptionJa,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dexNumber.present) {
      map['dex_number'] = Variable<int>(dexNumber.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (stageId.present) {
      map['stage_id'] = Variable<String>(stageId.value);
    }
    if (attributeId.present) {
      map['attribute_id'] = Variable<String>(attributeId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<String>(typeId.value);
    }
    if (elementId.present) {
      map['element_id'] = Variable<String>(elementId.value);
    }
    if (personalityId.present) {
      map['personality_id'] = Variable<String>(personalityId.value);
    }
    if (canDigiride.present) {
      map['can_digiride'] = Variable<bool>(canDigiride.value);
    }
    if (dlcPack.present) {
      map['dlc_pack'] = Variable<String>(dlcPack.value);
    }
    if (maxHp.present) {
      map['max_hp'] = Variable<int>(maxHp.value);
    }
    if (maxSp.present) {
      map['max_sp'] = Variable<int>(maxSp.value);
    }
    if (maxAtk.present) {
      map['max_atk'] = Variable<int>(maxAtk.value);
    }
    if (maxDef.present) {
      map['max_def'] = Variable<int>(maxDef.value);
    }
    if (maxInt.present) {
      map['max_int'] = Variable<int>(maxInt.value);
    }
    if (maxMen.present) {
      map['max_men'] = Variable<int>(maxMen.value);
    }
    if (maxSpd.present) {
      map['max_spd'] = Variable<int>(maxSpd.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (sourceUrlJa.present) {
      map['source_url_ja'] = Variable<String>(sourceUrlJa.value);
    }
    if (sourceUrlZh.present) {
      map['source_url_zh'] = Variable<String>(sourceUrlZh.value);
    }
    if (descriptionJa.present) {
      map['description_ja'] = Variable<String>(descriptionJa.value);
    }
    if (descriptionZh.present) {
      map['description_zh'] = Variable<String>(descriptionZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DigimonsCompanion(')
          ..write('id: $id, ')
          ..write('dexNumber: $dexNumber, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('nameEn: $nameEn, ')
          ..write('stageId: $stageId, ')
          ..write('attributeId: $attributeId, ')
          ..write('typeId: $typeId, ')
          ..write('elementId: $elementId, ')
          ..write('personalityId: $personalityId, ')
          ..write('canDigiride: $canDigiride, ')
          ..write('dlcPack: $dlcPack, ')
          ..write('maxHp: $maxHp, ')
          ..write('maxSp: $maxSp, ')
          ..write('maxAtk: $maxAtk, ')
          ..write('maxDef: $maxDef, ')
          ..write('maxInt: $maxInt, ')
          ..write('maxMen: $maxMen, ')
          ..write('maxSpd: $maxSpd, ')
          ..write('imagePath: $imagePath, ')
          ..write('sourceUrlJa: $sourceUrlJa, ')
          ..write('sourceUrlZh: $sourceUrlZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvolutionsTable extends Evolutions
    with TableInfo<$EvolutionsTable, EvolutionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fromIdMeta = const VerificationMeta('fromId');
  @override
  late final GeneratedColumn<String> fromId = GeneratedColumn<String>(
    'from_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES digimons (id)',
    ),
  );
  static const VerificationMeta _toIdMeta = const VerificationMeta('toId');
  @override
  late final GeneratedColumn<String> toId = GeneratedColumn<String>(
    'to_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES digimons (id)',
    ),
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('evolve'),
  );
  static const VerificationMeta _conditionTextJaMeta = const VerificationMeta(
    'conditionTextJa',
  );
  @override
  late final GeneratedColumn<String> conditionTextJa = GeneratedColumn<String>(
    'condition_text_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionTextZhMeta = const VerificationMeta(
    'conditionTextZh',
  );
  @override
  late final GeneratedColumn<String> conditionTextZh = GeneratedColumn<String>(
    'condition_text_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromId,
    toId,
    direction,
    conditionTextJa,
    conditionTextZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolutions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_id')) {
      context.handle(
        _fromIdMeta,
        fromId.isAcceptableOrUnknown(data['from_id']!, _fromIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fromIdMeta);
    }
    if (data.containsKey('to_id')) {
      context.handle(
        _toIdMeta,
        toId.isAcceptableOrUnknown(data['to_id']!, _toIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toIdMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    }
    if (data.containsKey('condition_text_ja')) {
      context.handle(
        _conditionTextJaMeta,
        conditionTextJa.isAcceptableOrUnknown(
          data['condition_text_ja']!,
          _conditionTextJaMeta,
        ),
      );
    }
    if (data.containsKey('condition_text_zh')) {
      context.handle(
        _conditionTextZhMeta,
        conditionTextZh.isAcceptableOrUnknown(
          data['condition_text_zh']!,
          _conditionTextZhMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvolutionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_id'],
      )!,
      toId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      conditionTextJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition_text_ja'],
      ),
      conditionTextZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition_text_zh'],
      ),
    );
  }

  @override
  $EvolutionsTable createAlias(String alias) {
    return $EvolutionsTable(attachedDatabase, alias);
  }
}

class EvolutionRow extends DataClass implements Insertable<EvolutionRow> {
  final int id;

  /// 來源數碼寶貝 slug。
  final String fromId;

  /// 目標數碼寶貝 slug。
  final String toId;

  /// 進化方向：'evolve' 進化 / 'devolve' 退化。
  final String direction;

  /// 條件原文（多行 `<br>` 串接後保留為單一字串，供 UI 直接顯示）。
  final String? conditionTextJa;
  final String? conditionTextZh;
  const EvolutionRow({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.direction,
    this.conditionTextJa,
    this.conditionTextZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_id'] = Variable<String>(fromId);
    map['to_id'] = Variable<String>(toId);
    map['direction'] = Variable<String>(direction);
    if (!nullToAbsent || conditionTextJa != null) {
      map['condition_text_ja'] = Variable<String>(conditionTextJa);
    }
    if (!nullToAbsent || conditionTextZh != null) {
      map['condition_text_zh'] = Variable<String>(conditionTextZh);
    }
    return map;
  }

  EvolutionsCompanion toCompanion(bool nullToAbsent) {
    return EvolutionsCompanion(
      id: Value(id),
      fromId: Value(fromId),
      toId: Value(toId),
      direction: Value(direction),
      conditionTextJa: conditionTextJa == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionTextJa),
      conditionTextZh: conditionTextZh == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionTextZh),
    );
  }

  factory EvolutionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionRow(
      id: serializer.fromJson<int>(json['id']),
      fromId: serializer.fromJson<String>(json['fromId']),
      toId: serializer.fromJson<String>(json['toId']),
      direction: serializer.fromJson<String>(json['direction']),
      conditionTextJa: serializer.fromJson<String?>(json['conditionTextJa']),
      conditionTextZh: serializer.fromJson<String?>(json['conditionTextZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromId': serializer.toJson<String>(fromId),
      'toId': serializer.toJson<String>(toId),
      'direction': serializer.toJson<String>(direction),
      'conditionTextJa': serializer.toJson<String?>(conditionTextJa),
      'conditionTextZh': serializer.toJson<String?>(conditionTextZh),
    };
  }

  EvolutionRow copyWith({
    int? id,
    String? fromId,
    String? toId,
    String? direction,
    Value<String?> conditionTextJa = const Value.absent(),
    Value<String?> conditionTextZh = const Value.absent(),
  }) => EvolutionRow(
    id: id ?? this.id,
    fromId: fromId ?? this.fromId,
    toId: toId ?? this.toId,
    direction: direction ?? this.direction,
    conditionTextJa: conditionTextJa.present
        ? conditionTextJa.value
        : this.conditionTextJa,
    conditionTextZh: conditionTextZh.present
        ? conditionTextZh.value
        : this.conditionTextZh,
  );
  EvolutionRow copyWithCompanion(EvolutionsCompanion data) {
    return EvolutionRow(
      id: data.id.present ? data.id.value : this.id,
      fromId: data.fromId.present ? data.fromId.value : this.fromId,
      toId: data.toId.present ? data.toId.value : this.toId,
      direction: data.direction.present ? data.direction.value : this.direction,
      conditionTextJa: data.conditionTextJa.present
          ? data.conditionTextJa.value
          : this.conditionTextJa,
      conditionTextZh: data.conditionTextZh.present
          ? data.conditionTextZh.value
          : this.conditionTextZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionRow(')
          ..write('id: $id, ')
          ..write('fromId: $fromId, ')
          ..write('toId: $toId, ')
          ..write('direction: $direction, ')
          ..write('conditionTextJa: $conditionTextJa, ')
          ..write('conditionTextZh: $conditionTextZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromId,
    toId,
    direction,
    conditionTextJa,
    conditionTextZh,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionRow &&
          other.id == this.id &&
          other.fromId == this.fromId &&
          other.toId == this.toId &&
          other.direction == this.direction &&
          other.conditionTextJa == this.conditionTextJa &&
          other.conditionTextZh == this.conditionTextZh);
}

class EvolutionsCompanion extends UpdateCompanion<EvolutionRow> {
  final Value<int> id;
  final Value<String> fromId;
  final Value<String> toId;
  final Value<String> direction;
  final Value<String?> conditionTextJa;
  final Value<String?> conditionTextZh;
  const EvolutionsCompanion({
    this.id = const Value.absent(),
    this.fromId = const Value.absent(),
    this.toId = const Value.absent(),
    this.direction = const Value.absent(),
    this.conditionTextJa = const Value.absent(),
    this.conditionTextZh = const Value.absent(),
  });
  EvolutionsCompanion.insert({
    this.id = const Value.absent(),
    required String fromId,
    required String toId,
    this.direction = const Value.absent(),
    this.conditionTextJa = const Value.absent(),
    this.conditionTextZh = const Value.absent(),
  }) : fromId = Value(fromId),
       toId = Value(toId);
  static Insertable<EvolutionRow> custom({
    Expression<int>? id,
    Expression<String>? fromId,
    Expression<String>? toId,
    Expression<String>? direction,
    Expression<String>? conditionTextJa,
    Expression<String>? conditionTextZh,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromId != null) 'from_id': fromId,
      if (toId != null) 'to_id': toId,
      if (direction != null) 'direction': direction,
      if (conditionTextJa != null) 'condition_text_ja': conditionTextJa,
      if (conditionTextZh != null) 'condition_text_zh': conditionTextZh,
    });
  }

  EvolutionsCompanion copyWith({
    Value<int>? id,
    Value<String>? fromId,
    Value<String>? toId,
    Value<String>? direction,
    Value<String?>? conditionTextJa,
    Value<String?>? conditionTextZh,
  }) {
    return EvolutionsCompanion(
      id: id ?? this.id,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      direction: direction ?? this.direction,
      conditionTextJa: conditionTextJa ?? this.conditionTextJa,
      conditionTextZh: conditionTextZh ?? this.conditionTextZh,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromId.present) {
      map['from_id'] = Variable<String>(fromId.value);
    }
    if (toId.present) {
      map['to_id'] = Variable<String>(toId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (conditionTextJa.present) {
      map['condition_text_ja'] = Variable<String>(conditionTextJa.value);
    }
    if (conditionTextZh.present) {
      map['condition_text_zh'] = Variable<String>(conditionTextZh.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionsCompanion(')
          ..write('id: $id, ')
          ..write('fromId: $fromId, ')
          ..write('toId: $toId, ')
          ..write('direction: $direction, ')
          ..write('conditionTextJa: $conditionTextJa, ')
          ..write('conditionTextZh: $conditionTextZh')
          ..write(')'))
        .toString();
  }
}

class $EvolutionConditionsTable extends EvolutionConditions
    with TableInfo<$EvolutionConditionsTable, EvolutionConditionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvolutionConditionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _evolutionIdMeta = const VerificationMeta(
    'evolutionId',
  );
  @override
  late final GeneratedColumn<int> evolutionId = GeneratedColumn<int>(
    'evolution_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES evolutions (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statIdMeta = const VerificationMeta('statId');
  @override
  late final GeneratedColumn<String> statId = GeneratedColumn<String>(
    'stat_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thresholdMeta = const VerificationMeta(
    'threshold',
  );
  @override
  late final GeneratedColumn<int> threshold = GeneratedColumn<int>(
    'threshold',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _digimonIdMeta = const VerificationMeta(
    'digimonId',
  );
  @override
  late final GeneratedColumn<String> digimonId = GeneratedColumn<String>(
    'digimon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES digimons (id)',
    ),
  );
  static const VerificationMeta _personalityIdMeta = const VerificationMeta(
    'personalityId',
  );
  @override
  late final GeneratedColumn<String> personalityId = GeneratedColumn<String>(
    'personality_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES personalities (id)',
    ),
  );
  static const VerificationMeta _textJaMeta = const VerificationMeta('textJa');
  @override
  late final GeneratedColumn<String> textJa = GeneratedColumn<String>(
    'text_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _textZhMeta = const VerificationMeta('textZh');
  @override
  late final GeneratedColumn<String> textZh = GeneratedColumn<String>(
    'text_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    evolutionId,
    kind,
    statId,
    threshold,
    digimonId,
    personalityId,
    textJa,
    textZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evolution_conditions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvolutionConditionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('evolution_id')) {
      context.handle(
        _evolutionIdMeta,
        evolutionId.isAcceptableOrUnknown(
          data['evolution_id']!,
          _evolutionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evolutionIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('stat_id')) {
      context.handle(
        _statIdMeta,
        statId.isAcceptableOrUnknown(data['stat_id']!, _statIdMeta),
      );
    }
    if (data.containsKey('threshold')) {
      context.handle(
        _thresholdMeta,
        threshold.isAcceptableOrUnknown(data['threshold']!, _thresholdMeta),
      );
    }
    if (data.containsKey('digimon_id')) {
      context.handle(
        _digimonIdMeta,
        digimonId.isAcceptableOrUnknown(data['digimon_id']!, _digimonIdMeta),
      );
    }
    if (data.containsKey('personality_id')) {
      context.handle(
        _personalityIdMeta,
        personalityId.isAcceptableOrUnknown(
          data['personality_id']!,
          _personalityIdMeta,
        ),
      );
    }
    if (data.containsKey('text_ja')) {
      context.handle(
        _textJaMeta,
        textJa.isAcceptableOrUnknown(data['text_ja']!, _textJaMeta),
      );
    }
    if (data.containsKey('text_zh')) {
      context.handle(
        _textZhMeta,
        textZh.isAcceptableOrUnknown(data['text_zh']!, _textZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvolutionConditionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvolutionConditionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      evolutionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      statId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stat_id'],
      ),
      threshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}threshold'],
      ),
      digimonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}digimon_id'],
      ),
      personalityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personality_id'],
      ),
      textJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_ja'],
      ),
      textZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_zh'],
      ),
    );
  }

  @override
  $EvolutionConditionsTable createAlias(String alias) {
    return $EvolutionConditionsTable(attachedDatabase, alias);
  }
}

class EvolutionConditionRow extends DataClass
    implements Insertable<EvolutionConditionRow> {
  final int id;
  final int evolutionId;

  /// 條件種類：
  /// - 'agent_rank'   ：エージェントランク N 以上 → threshold=N
  /// - 'stat_min'     ：某 stat 上限值 N 以上 → statId='hp'/'sp'/... + threshold=N
  /// - 'level'        ：等級 N 以上 → threshold=N
  /// - 'battles'      ：戰鬥次數 N → threshold=N
  /// - 'abi'          ：ABI N 以上 → threshold=N
  /// - 'personality'  ：「X 的性格須為 P」→ digimonId=X + personalityId=P
  ///                    （X = from_id 為自己；X ≠ from_id 為合體 partner）
  /// - 'item'         ：必要道具 → text_ja/zh
  /// - 'special'      ：其他 fallback → text_ja/zh
  final String kind;

  /// kind='stat_min' 時的 stat（FK stats.id）。
  final String? statId;

  /// 數值門檻（agent_rank / stat_min / level / battles / abi 用）。
  final int? threshold;

  /// 條件適用的 Digimon（kind='personality' 用；自己或合體 partner）。
  final String? digimonId;

  /// kind='personality' 用。
  final String? personalityId;

  /// 非數值類型的條件原文（kind='item' / 'special' 等用）。
  final String? textJa;
  final String? textZh;
  const EvolutionConditionRow({
    required this.id,
    required this.evolutionId,
    required this.kind,
    this.statId,
    this.threshold,
    this.digimonId,
    this.personalityId,
    this.textJa,
    this.textZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['evolution_id'] = Variable<int>(evolutionId);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || statId != null) {
      map['stat_id'] = Variable<String>(statId);
    }
    if (!nullToAbsent || threshold != null) {
      map['threshold'] = Variable<int>(threshold);
    }
    if (!nullToAbsent || digimonId != null) {
      map['digimon_id'] = Variable<String>(digimonId);
    }
    if (!nullToAbsent || personalityId != null) {
      map['personality_id'] = Variable<String>(personalityId);
    }
    if (!nullToAbsent || textJa != null) {
      map['text_ja'] = Variable<String>(textJa);
    }
    if (!nullToAbsent || textZh != null) {
      map['text_zh'] = Variable<String>(textZh);
    }
    return map;
  }

  EvolutionConditionsCompanion toCompanion(bool nullToAbsent) {
    return EvolutionConditionsCompanion(
      id: Value(id),
      evolutionId: Value(evolutionId),
      kind: Value(kind),
      statId: statId == null && nullToAbsent
          ? const Value.absent()
          : Value(statId),
      threshold: threshold == null && nullToAbsent
          ? const Value.absent()
          : Value(threshold),
      digimonId: digimonId == null && nullToAbsent
          ? const Value.absent()
          : Value(digimonId),
      personalityId: personalityId == null && nullToAbsent
          ? const Value.absent()
          : Value(personalityId),
      textJa: textJa == null && nullToAbsent
          ? const Value.absent()
          : Value(textJa),
      textZh: textZh == null && nullToAbsent
          ? const Value.absent()
          : Value(textZh),
    );
  }

  factory EvolutionConditionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvolutionConditionRow(
      id: serializer.fromJson<int>(json['id']),
      evolutionId: serializer.fromJson<int>(json['evolutionId']),
      kind: serializer.fromJson<String>(json['kind']),
      statId: serializer.fromJson<String?>(json['statId']),
      threshold: serializer.fromJson<int?>(json['threshold']),
      digimonId: serializer.fromJson<String?>(json['digimonId']),
      personalityId: serializer.fromJson<String?>(json['personalityId']),
      textJa: serializer.fromJson<String?>(json['textJa']),
      textZh: serializer.fromJson<String?>(json['textZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'evolutionId': serializer.toJson<int>(evolutionId),
      'kind': serializer.toJson<String>(kind),
      'statId': serializer.toJson<String?>(statId),
      'threshold': serializer.toJson<int?>(threshold),
      'digimonId': serializer.toJson<String?>(digimonId),
      'personalityId': serializer.toJson<String?>(personalityId),
      'textJa': serializer.toJson<String?>(textJa),
      'textZh': serializer.toJson<String?>(textZh),
    };
  }

  EvolutionConditionRow copyWith({
    int? id,
    int? evolutionId,
    String? kind,
    Value<String?> statId = const Value.absent(),
    Value<int?> threshold = const Value.absent(),
    Value<String?> digimonId = const Value.absent(),
    Value<String?> personalityId = const Value.absent(),
    Value<String?> textJa = const Value.absent(),
    Value<String?> textZh = const Value.absent(),
  }) => EvolutionConditionRow(
    id: id ?? this.id,
    evolutionId: evolutionId ?? this.evolutionId,
    kind: kind ?? this.kind,
    statId: statId.present ? statId.value : this.statId,
    threshold: threshold.present ? threshold.value : this.threshold,
    digimonId: digimonId.present ? digimonId.value : this.digimonId,
    personalityId: personalityId.present
        ? personalityId.value
        : this.personalityId,
    textJa: textJa.present ? textJa.value : this.textJa,
    textZh: textZh.present ? textZh.value : this.textZh,
  );
  EvolutionConditionRow copyWithCompanion(EvolutionConditionsCompanion data) {
    return EvolutionConditionRow(
      id: data.id.present ? data.id.value : this.id,
      evolutionId: data.evolutionId.present
          ? data.evolutionId.value
          : this.evolutionId,
      kind: data.kind.present ? data.kind.value : this.kind,
      statId: data.statId.present ? data.statId.value : this.statId,
      threshold: data.threshold.present ? data.threshold.value : this.threshold,
      digimonId: data.digimonId.present ? data.digimonId.value : this.digimonId,
      personalityId: data.personalityId.present
          ? data.personalityId.value
          : this.personalityId,
      textJa: data.textJa.present ? data.textJa.value : this.textJa,
      textZh: data.textZh.present ? data.textZh.value : this.textZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionConditionRow(')
          ..write('id: $id, ')
          ..write('evolutionId: $evolutionId, ')
          ..write('kind: $kind, ')
          ..write('statId: $statId, ')
          ..write('threshold: $threshold, ')
          ..write('digimonId: $digimonId, ')
          ..write('personalityId: $personalityId, ')
          ..write('textJa: $textJa, ')
          ..write('textZh: $textZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    evolutionId,
    kind,
    statId,
    threshold,
    digimonId,
    personalityId,
    textJa,
    textZh,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvolutionConditionRow &&
          other.id == this.id &&
          other.evolutionId == this.evolutionId &&
          other.kind == this.kind &&
          other.statId == this.statId &&
          other.threshold == this.threshold &&
          other.digimonId == this.digimonId &&
          other.personalityId == this.personalityId &&
          other.textJa == this.textJa &&
          other.textZh == this.textZh);
}

class EvolutionConditionsCompanion
    extends UpdateCompanion<EvolutionConditionRow> {
  final Value<int> id;
  final Value<int> evolutionId;
  final Value<String> kind;
  final Value<String?> statId;
  final Value<int?> threshold;
  final Value<String?> digimonId;
  final Value<String?> personalityId;
  final Value<String?> textJa;
  final Value<String?> textZh;
  const EvolutionConditionsCompanion({
    this.id = const Value.absent(),
    this.evolutionId = const Value.absent(),
    this.kind = const Value.absent(),
    this.statId = const Value.absent(),
    this.threshold = const Value.absent(),
    this.digimonId = const Value.absent(),
    this.personalityId = const Value.absent(),
    this.textJa = const Value.absent(),
    this.textZh = const Value.absent(),
  });
  EvolutionConditionsCompanion.insert({
    this.id = const Value.absent(),
    required int evolutionId,
    required String kind,
    this.statId = const Value.absent(),
    this.threshold = const Value.absent(),
    this.digimonId = const Value.absent(),
    this.personalityId = const Value.absent(),
    this.textJa = const Value.absent(),
    this.textZh = const Value.absent(),
  }) : evolutionId = Value(evolutionId),
       kind = Value(kind);
  static Insertable<EvolutionConditionRow> custom({
    Expression<int>? id,
    Expression<int>? evolutionId,
    Expression<String>? kind,
    Expression<String>? statId,
    Expression<int>? threshold,
    Expression<String>? digimonId,
    Expression<String>? personalityId,
    Expression<String>? textJa,
    Expression<String>? textZh,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (evolutionId != null) 'evolution_id': evolutionId,
      if (kind != null) 'kind': kind,
      if (statId != null) 'stat_id': statId,
      if (threshold != null) 'threshold': threshold,
      if (digimonId != null) 'digimon_id': digimonId,
      if (personalityId != null) 'personality_id': personalityId,
      if (textJa != null) 'text_ja': textJa,
      if (textZh != null) 'text_zh': textZh,
    });
  }

  EvolutionConditionsCompanion copyWith({
    Value<int>? id,
    Value<int>? evolutionId,
    Value<String>? kind,
    Value<String?>? statId,
    Value<int?>? threshold,
    Value<String?>? digimonId,
    Value<String?>? personalityId,
    Value<String?>? textJa,
    Value<String?>? textZh,
  }) {
    return EvolutionConditionsCompanion(
      id: id ?? this.id,
      evolutionId: evolutionId ?? this.evolutionId,
      kind: kind ?? this.kind,
      statId: statId ?? this.statId,
      threshold: threshold ?? this.threshold,
      digimonId: digimonId ?? this.digimonId,
      personalityId: personalityId ?? this.personalityId,
      textJa: textJa ?? this.textJa,
      textZh: textZh ?? this.textZh,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (evolutionId.present) {
      map['evolution_id'] = Variable<int>(evolutionId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (statId.present) {
      map['stat_id'] = Variable<String>(statId.value);
    }
    if (threshold.present) {
      map['threshold'] = Variable<int>(threshold.value);
    }
    if (digimonId.present) {
      map['digimon_id'] = Variable<String>(digimonId.value);
    }
    if (personalityId.present) {
      map['personality_id'] = Variable<String>(personalityId.value);
    }
    if (textJa.present) {
      map['text_ja'] = Variable<String>(textJa.value);
    }
    if (textZh.present) {
      map['text_zh'] = Variable<String>(textZh.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvolutionConditionsCompanion(')
          ..write('id: $id, ')
          ..write('evolutionId: $evolutionId, ')
          ..write('kind: $kind, ')
          ..write('statId: $statId, ')
          ..write('threshold: $threshold, ')
          ..write('digimonId: $digimonId, ')
          ..write('personalityId: $personalityId, ')
          ..write('textJa: $textJa, ')
          ..write('textZh: $textZh')
          ..write(')'))
        .toString();
  }
}

class $SkillCategoriesTable extends SkillCategories
    with TableInfo<$SkillCategoriesTable, SkillCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameJa, nameZh];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkillCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillCategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
    );
  }

  @override
  $SkillCategoriesTable createAlias(String alias) {
    return $SkillCategoriesTable(attachedDatabase, alias);
  }
}

class SkillCategoryRow extends DataClass
    implements Insertable<SkillCategoryRow> {
  final String id;
  final String nameJa;
  final String? nameZh;
  const SkillCategoryRow({required this.id, required this.nameJa, this.nameZh});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    return map;
  }

  SkillCategoriesCompanion toCompanion(bool nullToAbsent) {
    return SkillCategoriesCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
    );
  }

  factory SkillCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillCategoryRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
    };
  }

  SkillCategoryRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
  }) => SkillCategoryRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
  );
  SkillCategoryRow copyWithCompanion(SkillCategoriesCompanion data) {
    return SkillCategoryRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillCategoryRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameJa, nameZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillCategoryRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh);
}

class SkillCategoriesCompanion extends UpdateCompanion<SkillCategoryRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<int> rowid;
  const SkillCategoriesCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillCategoriesCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<SkillCategoryRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<int>? rowid,
  }) {
    return SkillCategoriesCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkillsTable extends Skills with TableInfo<$SkillsTable, SkillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elementIdMeta = const VerificationMeta(
    'elementId',
  );
  @override
  late final GeneratedColumn<String> elementId = GeneratedColumn<String>(
    'element_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES elements (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skill_categories (id)',
    ),
  );
  static const VerificationMeta _powerMeta = const VerificationMeta('power');
  @override
  late final GeneratedColumn<int> power = GeneratedColumn<int>(
    'power',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<int> accuracy = GeneratedColumn<int>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spCostMeta = const VerificationMeta('spCost');
  @override
  late final GeneratedColumn<int> spCost = GeneratedColumn<int>(
    'sp_cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetJaMeta = const VerificationMeta(
    'targetJa',
  );
  @override
  late final GeneratedColumn<String> targetJa = GeneratedColumn<String>(
    'target_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetZhMeta = const VerificationMeta(
    'targetZh',
  );
  @override
  late final GeneratedColumn<String> targetZh = GeneratedColumn<String>(
    'target_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionJaMeta = const VerificationMeta(
    'descriptionJa',
  );
  @override
  late final GeneratedColumn<String> descriptionJa = GeneratedColumn<String>(
    'description_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionZhMeta = const VerificationMeta(
    'descriptionZh',
  );
  @override
  late final GeneratedColumn<String> descriptionZh = GeneratedColumn<String>(
    'description_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameJa,
    nameZh,
    nameEn,
    elementId,
    categoryId,
    power,
    accuracy,
    spCost,
    targetJa,
    targetZh,
    descriptionJa,
    descriptionZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('element_id')) {
      context.handle(
        _elementIdMeta,
        elementId.isAcceptableOrUnknown(data['element_id']!, _elementIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('power')) {
      context.handle(
        _powerMeta,
        power.isAcceptableOrUnknown(data['power']!, _powerMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('sp_cost')) {
      context.handle(
        _spCostMeta,
        spCost.isAcceptableOrUnknown(data['sp_cost']!, _spCostMeta),
      );
    }
    if (data.containsKey('target_ja')) {
      context.handle(
        _targetJaMeta,
        targetJa.isAcceptableOrUnknown(data['target_ja']!, _targetJaMeta),
      );
    }
    if (data.containsKey('target_zh')) {
      context.handle(
        _targetZhMeta,
        targetZh.isAcceptableOrUnknown(data['target_zh']!, _targetZhMeta),
      );
    }
    if (data.containsKey('description_ja')) {
      context.handle(
        _descriptionJaMeta,
        descriptionJa.isAcceptableOrUnknown(
          data['description_ja']!,
          _descriptionJaMeta,
        ),
      );
    }
    if (data.containsKey('description_zh')) {
      context.handle(
        _descriptionZhMeta,
        descriptionZh.isAcceptableOrUnknown(
          data['description_zh']!,
          _descriptionZhMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      elementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}element_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      power: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accuracy'],
      ),
      spCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sp_cost'],
      ),
      targetJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_ja'],
      ),
      targetZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_zh'],
      ),
      descriptionJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ja'],
      ),
      descriptionZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_zh'],
      ),
    );
  }

  @override
  $SkillsTable createAlias(String alias) {
    return $SkillsTable(attachedDatabase, alias);
  }
}

class SkillRow extends DataClass implements Insertable<SkillRow> {
  /// 內部 slug。
  final String id;

  /// 技能名稱（日 / 中 / 英）。
  final String nameJa;
  final String? nameZh;
  final String? nameEn;

  /// 屬性（FK -> elements）。
  final String? elementId;

  /// 類型（FK -> skill_categories：special / attachment / normal 等）。
  final String? categoryId;

  /// 威力。
  final int? power;

  /// 命中。
  final int? accuracy;

  /// SP 消耗。
  final int? spCost;

  /// 目標（單體、全體、自己 等）。
  final String? targetJa;
  final String? targetZh;

  /// 效果描述（日 / 中）。
  final String? descriptionJa;
  final String? descriptionZh;
  const SkillRow({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.nameEn,
    this.elementId,
    this.categoryId,
    this.power,
    this.accuracy,
    this.spCost,
    this.targetJa,
    this.targetZh,
    this.descriptionJa,
    this.descriptionZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || elementId != null) {
      map['element_id'] = Variable<String>(elementId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || power != null) {
      map['power'] = Variable<int>(power);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<int>(accuracy);
    }
    if (!nullToAbsent || spCost != null) {
      map['sp_cost'] = Variable<int>(spCost);
    }
    if (!nullToAbsent || targetJa != null) {
      map['target_ja'] = Variable<String>(targetJa);
    }
    if (!nullToAbsent || targetZh != null) {
      map['target_zh'] = Variable<String>(targetZh);
    }
    if (!nullToAbsent || descriptionJa != null) {
      map['description_ja'] = Variable<String>(descriptionJa);
    }
    if (!nullToAbsent || descriptionZh != null) {
      map['description_zh'] = Variable<String>(descriptionZh);
    }
    return map;
  }

  SkillsCompanion toCompanion(bool nullToAbsent) {
    return SkillsCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      elementId: elementId == null && nullToAbsent
          ? const Value.absent()
          : Value(elementId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      power: power == null && nullToAbsent
          ? const Value.absent()
          : Value(power),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      spCost: spCost == null && nullToAbsent
          ? const Value.absent()
          : Value(spCost),
      targetJa: targetJa == null && nullToAbsent
          ? const Value.absent()
          : Value(targetJa),
      targetZh: targetZh == null && nullToAbsent
          ? const Value.absent()
          : Value(targetZh),
      descriptionJa: descriptionJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionJa),
      descriptionZh: descriptionZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionZh),
    );
  }

  factory SkillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      elementId: serializer.fromJson<String?>(json['elementId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      power: serializer.fromJson<int?>(json['power']),
      accuracy: serializer.fromJson<int?>(json['accuracy']),
      spCost: serializer.fromJson<int?>(json['spCost']),
      targetJa: serializer.fromJson<String?>(json['targetJa']),
      targetZh: serializer.fromJson<String?>(json['targetZh']),
      descriptionJa: serializer.fromJson<String?>(json['descriptionJa']),
      descriptionZh: serializer.fromJson<String?>(json['descriptionZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
      'nameEn': serializer.toJson<String?>(nameEn),
      'elementId': serializer.toJson<String?>(elementId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'power': serializer.toJson<int?>(power),
      'accuracy': serializer.toJson<int?>(accuracy),
      'spCost': serializer.toJson<int?>(spCost),
      'targetJa': serializer.toJson<String?>(targetJa),
      'targetZh': serializer.toJson<String?>(targetZh),
      'descriptionJa': serializer.toJson<String?>(descriptionJa),
      'descriptionZh': serializer.toJson<String?>(descriptionZh),
    };
  }

  SkillRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    Value<String?> elementId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<int?> power = const Value.absent(),
    Value<int?> accuracy = const Value.absent(),
    Value<int?> spCost = const Value.absent(),
    Value<String?> targetJa = const Value.absent(),
    Value<String?> targetZh = const Value.absent(),
    Value<String?> descriptionJa = const Value.absent(),
    Value<String?> descriptionZh = const Value.absent(),
  }) => SkillRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    elementId: elementId.present ? elementId.value : this.elementId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    power: power.present ? power.value : this.power,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    spCost: spCost.present ? spCost.value : this.spCost,
    targetJa: targetJa.present ? targetJa.value : this.targetJa,
    targetZh: targetZh.present ? targetZh.value : this.targetZh,
    descriptionJa: descriptionJa.present
        ? descriptionJa.value
        : this.descriptionJa,
    descriptionZh: descriptionZh.present
        ? descriptionZh.value
        : this.descriptionZh,
  );
  SkillRow copyWithCompanion(SkillsCompanion data) {
    return SkillRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      elementId: data.elementId.present ? data.elementId.value : this.elementId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      power: data.power.present ? data.power.value : this.power,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      spCost: data.spCost.present ? data.spCost.value : this.spCost,
      targetJa: data.targetJa.present ? data.targetJa.value : this.targetJa,
      targetZh: data.targetZh.present ? data.targetZh.value : this.targetZh,
      descriptionJa: data.descriptionJa.present
          ? data.descriptionJa.value
          : this.descriptionJa,
      descriptionZh: data.descriptionZh.present
          ? data.descriptionZh.value
          : this.descriptionZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('nameEn: $nameEn, ')
          ..write('elementId: $elementId, ')
          ..write('categoryId: $categoryId, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('spCost: $spCost, ')
          ..write('targetJa: $targetJa, ')
          ..write('targetZh: $targetZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameJa,
    nameZh,
    nameEn,
    elementId,
    categoryId,
    power,
    accuracy,
    spCost,
    targetJa,
    targetZh,
    descriptionJa,
    descriptionZh,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh &&
          other.nameEn == this.nameEn &&
          other.elementId == this.elementId &&
          other.categoryId == this.categoryId &&
          other.power == this.power &&
          other.accuracy == this.accuracy &&
          other.spCost == this.spCost &&
          other.targetJa == this.targetJa &&
          other.targetZh == this.targetZh &&
          other.descriptionJa == this.descriptionJa &&
          other.descriptionZh == this.descriptionZh);
}

class SkillsCompanion extends UpdateCompanion<SkillRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<String?> nameEn;
  final Value<String?> elementId;
  final Value<String?> categoryId;
  final Value<int?> power;
  final Value<int?> accuracy;
  final Value<int?> spCost;
  final Value<String?> targetJa;
  final Value<String?> targetZh;
  final Value<String?> descriptionJa;
  final Value<String?> descriptionZh;
  final Value<int> rowid;
  const SkillsCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.elementId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.spCost = const Value.absent(),
    this.targetJa = const Value.absent(),
    this.targetZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillsCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.elementId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.power = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.spCost = const Value.absent(),
    this.targetJa = const Value.absent(),
    this.targetZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<SkillRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<String>? nameEn,
    Expression<String>? elementId,
    Expression<String>? categoryId,
    Expression<int>? power,
    Expression<int>? accuracy,
    Expression<int>? spCost,
    Expression<String>? targetJa,
    Expression<String>? targetZh,
    Expression<String>? descriptionJa,
    Expression<String>? descriptionZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (nameEn != null) 'name_en': nameEn,
      if (elementId != null) 'element_id': elementId,
      if (categoryId != null) 'category_id': categoryId,
      if (power != null) 'power': power,
      if (accuracy != null) 'accuracy': accuracy,
      if (spCost != null) 'sp_cost': spCost,
      if (targetJa != null) 'target_ja': targetJa,
      if (targetZh != null) 'target_zh': targetZh,
      if (descriptionJa != null) 'description_ja': descriptionJa,
      if (descriptionZh != null) 'description_zh': descriptionZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<String?>? nameEn,
    Value<String?>? elementId,
    Value<String?>? categoryId,
    Value<int?>? power,
    Value<int?>? accuracy,
    Value<int?>? spCost,
    Value<String?>? targetJa,
    Value<String?>? targetZh,
    Value<String?>? descriptionJa,
    Value<String?>? descriptionZh,
    Value<int>? rowid,
  }) {
    return SkillsCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      nameEn: nameEn ?? this.nameEn,
      elementId: elementId ?? this.elementId,
      categoryId: categoryId ?? this.categoryId,
      power: power ?? this.power,
      accuracy: accuracy ?? this.accuracy,
      spCost: spCost ?? this.spCost,
      targetJa: targetJa ?? this.targetJa,
      targetZh: targetZh ?? this.targetZh,
      descriptionJa: descriptionJa ?? this.descriptionJa,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (elementId.present) {
      map['element_id'] = Variable<String>(elementId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (power.present) {
      map['power'] = Variable<int>(power.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<int>(accuracy.value);
    }
    if (spCost.present) {
      map['sp_cost'] = Variable<int>(spCost.value);
    }
    if (targetJa.present) {
      map['target_ja'] = Variable<String>(targetJa.value);
    }
    if (targetZh.present) {
      map['target_zh'] = Variable<String>(targetZh.value);
    }
    if (descriptionJa.present) {
      map['description_ja'] = Variable<String>(descriptionJa.value);
    }
    if (descriptionZh.present) {
      map['description_zh'] = Variable<String>(descriptionZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillsCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('nameEn: $nameEn, ')
          ..write('elementId: $elementId, ')
          ..write('categoryId: $categoryId, ')
          ..write('power: $power, ')
          ..write('accuracy: $accuracy, ')
          ..write('spCost: $spCost, ')
          ..write('targetJa: $targetJa, ')
          ..write('targetZh: $targetZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DigimonSkillsTable extends DigimonSkills
    with TableInfo<$DigimonSkillsTable, DigimonSkillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DigimonSkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _digimonIdMeta = const VerificationMeta(
    'digimonId',
  );
  @override
  late final GeneratedColumn<String> digimonId = GeneratedColumn<String>(
    'digimon_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES digimons (id)',
    ),
  );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<String> skillId = GeneratedColumn<String>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skills (id)',
    ),
  );
  static const VerificationMeta _acquisitionMeta = const VerificationMeta(
    'acquisition',
  );
  @override
  late final GeneratedColumn<String> acquisition = GeneratedColumn<String>(
    'acquisition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('level'),
  );
  static const VerificationMeta _learnLevelMeta = const VerificationMeta(
    'learnLevel',
  );
  @override
  late final GeneratedColumn<int> learnLevel = GeneratedColumn<int>(
    'learn_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteJaMeta = const VerificationMeta('noteJa');
  @override
  late final GeneratedColumn<String> noteJa = GeneratedColumn<String>(
    'note_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteZhMeta = const VerificationMeta('noteZh');
  @override
  late final GeneratedColumn<String> noteZh = GeneratedColumn<String>(
    'note_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    digimonId,
    skillId,
    acquisition,
    learnLevel,
    noteJa,
    noteZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'digimon_skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<DigimonSkillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('digimon_id')) {
      context.handle(
        _digimonIdMeta,
        digimonId.isAcceptableOrUnknown(data['digimon_id']!, _digimonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_digimonIdMeta);
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('acquisition')) {
      context.handle(
        _acquisitionMeta,
        acquisition.isAcceptableOrUnknown(
          data['acquisition']!,
          _acquisitionMeta,
        ),
      );
    }
    if (data.containsKey('learn_level')) {
      context.handle(
        _learnLevelMeta,
        learnLevel.isAcceptableOrUnknown(data['learn_level']!, _learnLevelMeta),
      );
    }
    if (data.containsKey('note_ja')) {
      context.handle(
        _noteJaMeta,
        noteJa.isAcceptableOrUnknown(data['note_ja']!, _noteJaMeta),
      );
    }
    if (data.containsKey('note_zh')) {
      context.handle(
        _noteZhMeta,
        noteZh.isAcceptableOrUnknown(data['note_zh']!, _noteZhMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DigimonSkillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DigimonSkillRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      digimonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}digimon_id'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skill_id'],
      )!,
      acquisition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}acquisition'],
      )!,
      learnLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}learn_level'],
      ),
      noteJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_ja'],
      ),
      noteZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_zh'],
      ),
    );
  }

  @override
  $DigimonSkillsTable createAlias(String alias) {
    return $DigimonSkillsTable(attachedDatabase, alias);
  }
}

class DigimonSkillRow extends DataClass implements Insertable<DigimonSkillRow> {
  final int id;
  final String digimonId;
  final String skillId;

  /// 習得方式：'level' / 'inherit' / 'event' / 'item' 等。
  final String acquisition;

  /// 習得等級（若 acquisition = 'level'）。
  final int? learnLevel;

  /// 備註（日 / 中）。
  final String? noteJa;
  final String? noteZh;
  const DigimonSkillRow({
    required this.id,
    required this.digimonId,
    required this.skillId,
    required this.acquisition,
    this.learnLevel,
    this.noteJa,
    this.noteZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['digimon_id'] = Variable<String>(digimonId);
    map['skill_id'] = Variable<String>(skillId);
    map['acquisition'] = Variable<String>(acquisition);
    if (!nullToAbsent || learnLevel != null) {
      map['learn_level'] = Variable<int>(learnLevel);
    }
    if (!nullToAbsent || noteJa != null) {
      map['note_ja'] = Variable<String>(noteJa);
    }
    if (!nullToAbsent || noteZh != null) {
      map['note_zh'] = Variable<String>(noteZh);
    }
    return map;
  }

  DigimonSkillsCompanion toCompanion(bool nullToAbsent) {
    return DigimonSkillsCompanion(
      id: Value(id),
      digimonId: Value(digimonId),
      skillId: Value(skillId),
      acquisition: Value(acquisition),
      learnLevel: learnLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(learnLevel),
      noteJa: noteJa == null && nullToAbsent
          ? const Value.absent()
          : Value(noteJa),
      noteZh: noteZh == null && nullToAbsent
          ? const Value.absent()
          : Value(noteZh),
    );
  }

  factory DigimonSkillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DigimonSkillRow(
      id: serializer.fromJson<int>(json['id']),
      digimonId: serializer.fromJson<String>(json['digimonId']),
      skillId: serializer.fromJson<String>(json['skillId']),
      acquisition: serializer.fromJson<String>(json['acquisition']),
      learnLevel: serializer.fromJson<int?>(json['learnLevel']),
      noteJa: serializer.fromJson<String?>(json['noteJa']),
      noteZh: serializer.fromJson<String?>(json['noteZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'digimonId': serializer.toJson<String>(digimonId),
      'skillId': serializer.toJson<String>(skillId),
      'acquisition': serializer.toJson<String>(acquisition),
      'learnLevel': serializer.toJson<int?>(learnLevel),
      'noteJa': serializer.toJson<String?>(noteJa),
      'noteZh': serializer.toJson<String?>(noteZh),
    };
  }

  DigimonSkillRow copyWith({
    int? id,
    String? digimonId,
    String? skillId,
    String? acquisition,
    Value<int?> learnLevel = const Value.absent(),
    Value<String?> noteJa = const Value.absent(),
    Value<String?> noteZh = const Value.absent(),
  }) => DigimonSkillRow(
    id: id ?? this.id,
    digimonId: digimonId ?? this.digimonId,
    skillId: skillId ?? this.skillId,
    acquisition: acquisition ?? this.acquisition,
    learnLevel: learnLevel.present ? learnLevel.value : this.learnLevel,
    noteJa: noteJa.present ? noteJa.value : this.noteJa,
    noteZh: noteZh.present ? noteZh.value : this.noteZh,
  );
  DigimonSkillRow copyWithCompanion(DigimonSkillsCompanion data) {
    return DigimonSkillRow(
      id: data.id.present ? data.id.value : this.id,
      digimonId: data.digimonId.present ? data.digimonId.value : this.digimonId,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      acquisition: data.acquisition.present
          ? data.acquisition.value
          : this.acquisition,
      learnLevel: data.learnLevel.present
          ? data.learnLevel.value
          : this.learnLevel,
      noteJa: data.noteJa.present ? data.noteJa.value : this.noteJa,
      noteZh: data.noteZh.present ? data.noteZh.value : this.noteZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DigimonSkillRow(')
          ..write('id: $id, ')
          ..write('digimonId: $digimonId, ')
          ..write('skillId: $skillId, ')
          ..write('acquisition: $acquisition, ')
          ..write('learnLevel: $learnLevel, ')
          ..write('noteJa: $noteJa, ')
          ..write('noteZh: $noteZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    digimonId,
    skillId,
    acquisition,
    learnLevel,
    noteJa,
    noteZh,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DigimonSkillRow &&
          other.id == this.id &&
          other.digimonId == this.digimonId &&
          other.skillId == this.skillId &&
          other.acquisition == this.acquisition &&
          other.learnLevel == this.learnLevel &&
          other.noteJa == this.noteJa &&
          other.noteZh == this.noteZh);
}

class DigimonSkillsCompanion extends UpdateCompanion<DigimonSkillRow> {
  final Value<int> id;
  final Value<String> digimonId;
  final Value<String> skillId;
  final Value<String> acquisition;
  final Value<int?> learnLevel;
  final Value<String?> noteJa;
  final Value<String?> noteZh;
  const DigimonSkillsCompanion({
    this.id = const Value.absent(),
    this.digimonId = const Value.absent(),
    this.skillId = const Value.absent(),
    this.acquisition = const Value.absent(),
    this.learnLevel = const Value.absent(),
    this.noteJa = const Value.absent(),
    this.noteZh = const Value.absent(),
  });
  DigimonSkillsCompanion.insert({
    this.id = const Value.absent(),
    required String digimonId,
    required String skillId,
    this.acquisition = const Value.absent(),
    this.learnLevel = const Value.absent(),
    this.noteJa = const Value.absent(),
    this.noteZh = const Value.absent(),
  }) : digimonId = Value(digimonId),
       skillId = Value(skillId);
  static Insertable<DigimonSkillRow> custom({
    Expression<int>? id,
    Expression<String>? digimonId,
    Expression<String>? skillId,
    Expression<String>? acquisition,
    Expression<int>? learnLevel,
    Expression<String>? noteJa,
    Expression<String>? noteZh,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (digimonId != null) 'digimon_id': digimonId,
      if (skillId != null) 'skill_id': skillId,
      if (acquisition != null) 'acquisition': acquisition,
      if (learnLevel != null) 'learn_level': learnLevel,
      if (noteJa != null) 'note_ja': noteJa,
      if (noteZh != null) 'note_zh': noteZh,
    });
  }

  DigimonSkillsCompanion copyWith({
    Value<int>? id,
    Value<String>? digimonId,
    Value<String>? skillId,
    Value<String>? acquisition,
    Value<int?>? learnLevel,
    Value<String?>? noteJa,
    Value<String?>? noteZh,
  }) {
    return DigimonSkillsCompanion(
      id: id ?? this.id,
      digimonId: digimonId ?? this.digimonId,
      skillId: skillId ?? this.skillId,
      acquisition: acquisition ?? this.acquisition,
      learnLevel: learnLevel ?? this.learnLevel,
      noteJa: noteJa ?? this.noteJa,
      noteZh: noteZh ?? this.noteZh,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (digimonId.present) {
      map['digimon_id'] = Variable<String>(digimonId.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<String>(skillId.value);
    }
    if (acquisition.present) {
      map['acquisition'] = Variable<String>(acquisition.value);
    }
    if (learnLevel.present) {
      map['learn_level'] = Variable<int>(learnLevel.value);
    }
    if (noteJa.present) {
      map['note_ja'] = Variable<String>(noteJa.value);
    }
    if (noteZh.present) {
      map['note_zh'] = Variable<String>(noteZh.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DigimonSkillsCompanion(')
          ..write('id: $id, ')
          ..write('digimonId: $digimonId, ')
          ..write('skillId: $skillId, ')
          ..write('acquisition: $acquisition, ')
          ..write('learnLevel: $learnLevel, ')
          ..write('noteJa: $noteJa, ')
          ..write('noteZh: $noteZh')
          ..write(')'))
        .toString();
  }
}

class $StatsTable extends Stats with TableInfo<$StatsTable, StatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionJaMeta = const VerificationMeta(
    'descriptionJa',
  );
  @override
  late final GeneratedColumn<String> descriptionJa = GeneratedColumn<String>(
    'description_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionZhMeta = const VerificationMeta(
    'descriptionZh',
  );
  @override
  late final GeneratedColumn<String> descriptionZh = GeneratedColumn<String>(
    'description_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameJa,
    nameZh,
    descriptionJa,
    descriptionZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<StatRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    } else if (isInserting) {
      context.missing(_nameJaMeta);
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('description_ja')) {
      context.handle(
        _descriptionJaMeta,
        descriptionJa.isAcceptableOrUnknown(
          data['description_ja']!,
          _descriptionJaMeta,
        ),
      );
    }
    if (data.containsKey('description_zh')) {
      context.handle(
        _descriptionZhMeta,
        descriptionZh.isAcceptableOrUnknown(
          data['description_zh']!,
          _descriptionZhMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      )!,
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      descriptionJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ja'],
      ),
      descriptionZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_zh'],
      ),
    );
  }

  @override
  $StatsTable createAlias(String alias) {
    return $StatsTable(attachedDatabase, alias);
  }
}

class StatRow extends DataClass implements Insertable<StatRow> {
  final String id;
  final String nameJa;
  final String? nameZh;
  final String? descriptionJa;
  final String? descriptionZh;
  const StatRow({
    required this.id,
    required this.nameJa,
    this.nameZh,
    this.descriptionJa,
    this.descriptionZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ja'] = Variable<String>(nameJa);
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || descriptionJa != null) {
      map['description_ja'] = Variable<String>(descriptionJa);
    }
    if (!nullToAbsent || descriptionZh != null) {
      map['description_zh'] = Variable<String>(descriptionZh);
    }
    return map;
  }

  StatsCompanion toCompanion(bool nullToAbsent) {
    return StatsCompanion(
      id: Value(id),
      nameJa: Value(nameJa),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      descriptionJa: descriptionJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionJa),
      descriptionZh: descriptionZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionZh),
    );
  }

  factory StatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatRow(
      id: serializer.fromJson<String>(json['id']),
      nameJa: serializer.fromJson<String>(json['nameJa']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      descriptionJa: serializer.fromJson<String?>(json['descriptionJa']),
      descriptionZh: serializer.fromJson<String?>(json['descriptionZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameJa': serializer.toJson<String>(nameJa),
      'nameZh': serializer.toJson<String?>(nameZh),
      'descriptionJa': serializer.toJson<String?>(descriptionJa),
      'descriptionZh': serializer.toJson<String?>(descriptionZh),
    };
  }

  StatRow copyWith({
    String? id,
    String? nameJa,
    Value<String?> nameZh = const Value.absent(),
    Value<String?> descriptionJa = const Value.absent(),
    Value<String?> descriptionZh = const Value.absent(),
  }) => StatRow(
    id: id ?? this.id,
    nameJa: nameJa ?? this.nameJa,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    descriptionJa: descriptionJa.present
        ? descriptionJa.value
        : this.descriptionJa,
    descriptionZh: descriptionZh.present
        ? descriptionZh.value
        : this.descriptionZh,
  );
  StatRow copyWithCompanion(StatsCompanion data) {
    return StatRow(
      id: data.id.present ? data.id.value : this.id,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      descriptionJa: data.descriptionJa.present
          ? data.descriptionJa.value
          : this.descriptionJa,
      descriptionZh: data.descriptionZh.present
          ? data.descriptionZh.value
          : this.descriptionZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatRow(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nameJa, nameZh, descriptionJa, descriptionZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatRow &&
          other.id == this.id &&
          other.nameJa == this.nameJa &&
          other.nameZh == this.nameZh &&
          other.descriptionJa == this.descriptionJa &&
          other.descriptionZh == this.descriptionZh);
}

class StatsCompanion extends UpdateCompanion<StatRow> {
  final Value<String> id;
  final Value<String> nameJa;
  final Value<String?> nameZh;
  final Value<String?> descriptionJa;
  final Value<String?> descriptionZh;
  final Value<int> rowid;
  const StatsCompanion({
    this.id = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StatsCompanion.insert({
    required String id,
    required String nameJa,
    this.nameZh = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameJa = Value(nameJa);
  static Insertable<StatRow> custom({
    Expression<String>? id,
    Expression<String>? nameJa,
    Expression<String>? nameZh,
    Expression<String>? descriptionJa,
    Expression<String>? descriptionZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameJa != null) 'name_ja': nameJa,
      if (nameZh != null) 'name_zh': nameZh,
      if (descriptionJa != null) 'description_ja': descriptionJa,
      if (descriptionZh != null) 'description_zh': descriptionZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StatsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameJa,
    Value<String?>? nameZh,
    Value<String?>? descriptionJa,
    Value<String?>? descriptionZh,
    Value<int>? rowid,
  }) {
    return StatsCompanion(
      id: id ?? this.id,
      nameJa: nameJa ?? this.nameJa,
      nameZh: nameZh ?? this.nameZh,
      descriptionJa: descriptionJa ?? this.descriptionJa,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (descriptionJa.present) {
      map['description_ja'] = Variable<String>(descriptionJa.value);
    }
    if (descriptionZh.present) {
      map['description_zh'] = Variable<String>(descriptionZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsCompanion(')
          ..write('id: $id, ')
          ..write('nameJa: $nameJa, ')
          ..write('nameZh: $nameZh, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GlossaryTable extends Glossary
    with TableInfo<$GlossaryTable, GlossaryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlossaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _termJaMeta = const VerificationMeta('termJa');
  @override
  late final GeneratedColumn<String> termJa = GeneratedColumn<String>(
    'term_ja',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _termZhMeta = const VerificationMeta('termZh');
  @override
  late final GeneratedColumn<String> termZh = GeneratedColumn<String>(
    'term_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionJaMeta = const VerificationMeta(
    'descriptionJa',
  );
  @override
  late final GeneratedColumn<String> descriptionJa = GeneratedColumn<String>(
    'description_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionZhMeta = const VerificationMeta(
    'descriptionZh',
  );
  @override
  late final GeneratedColumn<String> descriptionZh = GeneratedColumn<String>(
    'description_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    termJa,
    termZh,
    category,
    descriptionJa,
    descriptionZh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'glossary';
  @override
  VerificationContext validateIntegrity(
    Insertable<GlossaryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('term_ja')) {
      context.handle(
        _termJaMeta,
        termJa.isAcceptableOrUnknown(data['term_ja']!, _termJaMeta),
      );
    } else if (isInserting) {
      context.missing(_termJaMeta);
    }
    if (data.containsKey('term_zh')) {
      context.handle(
        _termZhMeta,
        termZh.isAcceptableOrUnknown(data['term_zh']!, _termZhMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('description_ja')) {
      context.handle(
        _descriptionJaMeta,
        descriptionJa.isAcceptableOrUnknown(
          data['description_ja']!,
          _descriptionJaMeta,
        ),
      );
    }
    if (data.containsKey('description_zh')) {
      context.handle(
        _descriptionZhMeta,
        descriptionZh.isAcceptableOrUnknown(
          data['description_zh']!,
          _descriptionZhMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlossaryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlossaryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      termJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term_ja'],
      )!,
      termZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term_zh'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      descriptionJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ja'],
      ),
      descriptionZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_zh'],
      ),
    );
  }

  @override
  $GlossaryTable createAlias(String alias) {
    return $GlossaryTable(attachedDatabase, alias);
  }
}

class GlossaryRow extends DataClass implements Insertable<GlossaryRow> {
  final String id;
  final String termJa;
  final String? termZh;
  final String? category;
  final String? descriptionJa;
  final String? descriptionZh;
  const GlossaryRow({
    required this.id,
    required this.termJa,
    this.termZh,
    this.category,
    this.descriptionJa,
    this.descriptionZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['term_ja'] = Variable<String>(termJa);
    if (!nullToAbsent || termZh != null) {
      map['term_zh'] = Variable<String>(termZh);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || descriptionJa != null) {
      map['description_ja'] = Variable<String>(descriptionJa);
    }
    if (!nullToAbsent || descriptionZh != null) {
      map['description_zh'] = Variable<String>(descriptionZh);
    }
    return map;
  }

  GlossaryCompanion toCompanion(bool nullToAbsent) {
    return GlossaryCompanion(
      id: Value(id),
      termJa: Value(termJa),
      termZh: termZh == null && nullToAbsent
          ? const Value.absent()
          : Value(termZh),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      descriptionJa: descriptionJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionJa),
      descriptionZh: descriptionZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionZh),
    );
  }

  factory GlossaryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlossaryRow(
      id: serializer.fromJson<String>(json['id']),
      termJa: serializer.fromJson<String>(json['termJa']),
      termZh: serializer.fromJson<String?>(json['termZh']),
      category: serializer.fromJson<String?>(json['category']),
      descriptionJa: serializer.fromJson<String?>(json['descriptionJa']),
      descriptionZh: serializer.fromJson<String?>(json['descriptionZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'termJa': serializer.toJson<String>(termJa),
      'termZh': serializer.toJson<String?>(termZh),
      'category': serializer.toJson<String?>(category),
      'descriptionJa': serializer.toJson<String?>(descriptionJa),
      'descriptionZh': serializer.toJson<String?>(descriptionZh),
    };
  }

  GlossaryRow copyWith({
    String? id,
    String? termJa,
    Value<String?> termZh = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> descriptionJa = const Value.absent(),
    Value<String?> descriptionZh = const Value.absent(),
  }) => GlossaryRow(
    id: id ?? this.id,
    termJa: termJa ?? this.termJa,
    termZh: termZh.present ? termZh.value : this.termZh,
    category: category.present ? category.value : this.category,
    descriptionJa: descriptionJa.present
        ? descriptionJa.value
        : this.descriptionJa,
    descriptionZh: descriptionZh.present
        ? descriptionZh.value
        : this.descriptionZh,
  );
  GlossaryRow copyWithCompanion(GlossaryCompanion data) {
    return GlossaryRow(
      id: data.id.present ? data.id.value : this.id,
      termJa: data.termJa.present ? data.termJa.value : this.termJa,
      termZh: data.termZh.present ? data.termZh.value : this.termZh,
      category: data.category.present ? data.category.value : this.category,
      descriptionJa: data.descriptionJa.present
          ? data.descriptionJa.value
          : this.descriptionJa,
      descriptionZh: data.descriptionZh.present
          ? data.descriptionZh.value
          : this.descriptionZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlossaryRow(')
          ..write('id: $id, ')
          ..write('termJa: $termJa, ')
          ..write('termZh: $termZh, ')
          ..write('category: $category, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, termJa, termZh, category, descriptionJa, descriptionZh);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlossaryRow &&
          other.id == this.id &&
          other.termJa == this.termJa &&
          other.termZh == this.termZh &&
          other.category == this.category &&
          other.descriptionJa == this.descriptionJa &&
          other.descriptionZh == this.descriptionZh);
}

class GlossaryCompanion extends UpdateCompanion<GlossaryRow> {
  final Value<String> id;
  final Value<String> termJa;
  final Value<String?> termZh;
  final Value<String?> category;
  final Value<String?> descriptionJa;
  final Value<String?> descriptionZh;
  final Value<int> rowid;
  const GlossaryCompanion({
    this.id = const Value.absent(),
    this.termJa = const Value.absent(),
    this.termZh = const Value.absent(),
    this.category = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GlossaryCompanion.insert({
    required String id,
    required String termJa,
    this.termZh = const Value.absent(),
    this.category = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.descriptionZh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       termJa = Value(termJa);
  static Insertable<GlossaryRow> custom({
    Expression<String>? id,
    Expression<String>? termJa,
    Expression<String>? termZh,
    Expression<String>? category,
    Expression<String>? descriptionJa,
    Expression<String>? descriptionZh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (termJa != null) 'term_ja': termJa,
      if (termZh != null) 'term_zh': termZh,
      if (category != null) 'category': category,
      if (descriptionJa != null) 'description_ja': descriptionJa,
      if (descriptionZh != null) 'description_zh': descriptionZh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GlossaryCompanion copyWith({
    Value<String>? id,
    Value<String>? termJa,
    Value<String?>? termZh,
    Value<String?>? category,
    Value<String?>? descriptionJa,
    Value<String?>? descriptionZh,
    Value<int>? rowid,
  }) {
    return GlossaryCompanion(
      id: id ?? this.id,
      termJa: termJa ?? this.termJa,
      termZh: termZh ?? this.termZh,
      category: category ?? this.category,
      descriptionJa: descriptionJa ?? this.descriptionJa,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (termJa.present) {
      map['term_ja'] = Variable<String>(termJa.value);
    }
    if (termZh.present) {
      map['term_zh'] = Variable<String>(termZh.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (descriptionJa.present) {
      map['description_ja'] = Variable<String>(descriptionJa.value);
    }
    if (descriptionZh.present) {
      map['description_zh'] = Variable<String>(descriptionZh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlossaryCompanion(')
          ..write('id: $id, ')
          ..write('termJa: $termJa, ')
          ..write('termZh: $termZh, ')
          ..write('category: $category, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('descriptionZh: $descriptionZh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StagesTable stages = $StagesTable(this);
  late final $AttributesTable attributes = $AttributesTable(this);
  late final $TypesTable types = $TypesTable(this);
  late final $ElementsTable elements = $ElementsTable(this);
  late final $PersonalitiesTable personalities = $PersonalitiesTable(this);
  late final $DigimonsTable digimons = $DigimonsTable(this);
  late final $EvolutionsTable evolutions = $EvolutionsTable(this);
  late final $EvolutionConditionsTable evolutionConditions =
      $EvolutionConditionsTable(this);
  late final $SkillCategoriesTable skillCategories = $SkillCategoriesTable(
    this,
  );
  late final $SkillsTable skills = $SkillsTable(this);
  late final $DigimonSkillsTable digimonSkills = $DigimonSkillsTable(this);
  late final $StatsTable stats = $StatsTable(this);
  late final $GlossaryTable glossary = $GlossaryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stages,
    attributes,
    types,
    elements,
    personalities,
    digimons,
    evolutions,
    evolutionConditions,
    skillCategories,
    skills,
    digimonSkills,
    stats,
    glossary,
  ];
}

typedef $$StagesTableCreateCompanionBuilder =
    StagesCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<int?> sortOrder,
      Value<int> rowid,
    });
typedef $$StagesTableUpdateCompanionBuilder =
    StagesCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<int?> sortOrder,
      Value<int> rowid,
    });

final class $$StagesTableReferences
    extends BaseReferences<_$AppDatabase, $StagesTable, StageRow> {
  $$StagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DigimonsTable, List<DigimonRow>>
  _digimonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimons,
    aliasName: $_aliasNameGenerator(db.stages.id, db.digimons.stageId),
  );

  $$DigimonsTableProcessedTableManager get digimonsRefs {
    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.stageId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StagesTableFilterComposer
    extends Composer<_$AppDatabase, $StagesTable> {
  $$StagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> digimonsRefs(
    Expression<bool> Function($$DigimonsTableFilterComposer f) f,
  ) {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.stageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StagesTableOrderingComposer
    extends Composer<_$AppDatabase, $StagesTable> {
  $$StagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StagesTable> {
  $$StagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> digimonsRefs<T extends Object>(
    Expression<T> Function($$DigimonsTableAnnotationComposer a) f,
  ) {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.stageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StagesTable,
          StageRow,
          $$StagesTableFilterComposer,
          $$StagesTableOrderingComposer,
          $$StagesTableAnnotationComposer,
          $$StagesTableCreateCompanionBuilder,
          $$StagesTableUpdateCompanionBuilder,
          (StageRow, $$StagesTableReferences),
          StageRow,
          PrefetchHooks Function({bool digimonsRefs})
        > {
  $$StagesTableTableManager(_$AppDatabase db, $StagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StagesCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<int?> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StagesCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$StagesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({digimonsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (digimonsRefs) db.digimons],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (digimonsRefs)
                    await $_getPrefetchedData<
                      StageRow,
                      $StagesTable,
                      DigimonRow
                    >(
                      currentTable: table,
                      referencedTable: $$StagesTableReferences
                          ._digimonsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StagesTableReferences(db, table, p0).digimonsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.stageId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StagesTable,
      StageRow,
      $$StagesTableFilterComposer,
      $$StagesTableOrderingComposer,
      $$StagesTableAnnotationComposer,
      $$StagesTableCreateCompanionBuilder,
      $$StagesTableUpdateCompanionBuilder,
      (StageRow, $$StagesTableReferences),
      StageRow,
      PrefetchHooks Function({bool digimonsRefs})
    >;
typedef $$AttributesTableCreateCompanionBuilder =
    AttributesCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });
typedef $$AttributesTableUpdateCompanionBuilder =
    AttributesCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });

final class $$AttributesTableReferences
    extends BaseReferences<_$AppDatabase, $AttributesTable, AttributeRow> {
  $$AttributesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DigimonsTable, List<DigimonRow>>
  _digimonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimons,
    aliasName: $_aliasNameGenerator(db.attributes.id, db.digimons.attributeId),
  );

  $$DigimonsTableProcessedTableManager get digimonsRefs {
    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.attributeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AttributesTableFilterComposer
    extends Composer<_$AppDatabase, $AttributesTable> {
  $$AttributesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> digimonsRefs(
    Expression<bool> Function($$DigimonsTableFilterComposer f) f,
  ) {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.attributeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttributesTableOrderingComposer
    extends Composer<_$AppDatabase, $AttributesTable> {
  $$AttributesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttributesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttributesTable> {
  $$AttributesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  Expression<T> digimonsRefs<T extends Object>(
    Expression<T> Function($$DigimonsTableAnnotationComposer a) f,
  ) {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.attributeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttributesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttributesTable,
          AttributeRow,
          $$AttributesTableFilterComposer,
          $$AttributesTableOrderingComposer,
          $$AttributesTableAnnotationComposer,
          $$AttributesTableCreateCompanionBuilder,
          $$AttributesTableUpdateCompanionBuilder,
          (AttributeRow, $$AttributesTableReferences),
          AttributeRow,
          PrefetchHooks Function({bool digimonsRefs})
        > {
  $$AttributesTableTableManager(_$AppDatabase db, $AttributesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttributesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttributesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttributesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttributesCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttributesCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttributesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({digimonsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (digimonsRefs) db.digimons],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (digimonsRefs)
                    await $_getPrefetchedData<
                      AttributeRow,
                      $AttributesTable,
                      DigimonRow
                    >(
                      currentTable: table,
                      referencedTable: $$AttributesTableReferences
                          ._digimonsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AttributesTableReferences(
                            db,
                            table,
                            p0,
                          ).digimonsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.attributeId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AttributesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttributesTable,
      AttributeRow,
      $$AttributesTableFilterComposer,
      $$AttributesTableOrderingComposer,
      $$AttributesTableAnnotationComposer,
      $$AttributesTableCreateCompanionBuilder,
      $$AttributesTableUpdateCompanionBuilder,
      (AttributeRow, $$AttributesTableReferences),
      AttributeRow,
      PrefetchHooks Function({bool digimonsRefs})
    >;
typedef $$TypesTableCreateCompanionBuilder =
    TypesCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });
typedef $$TypesTableUpdateCompanionBuilder =
    TypesCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });

final class $$TypesTableReferences
    extends BaseReferences<_$AppDatabase, $TypesTable, TypeRow> {
  $$TypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DigimonsTable, List<DigimonRow>>
  _digimonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimons,
    aliasName: $_aliasNameGenerator(db.types.id, db.digimons.typeId),
  );

  $$DigimonsTableProcessedTableManager get digimonsRefs {
    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesTableFilterComposer extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> digimonsRefs(
    Expression<bool> Function($$DigimonsTableFilterComposer f) f,
  ) {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  Expression<T> digimonsRefs<T extends Object>(
    Expression<T> Function($$DigimonsTableAnnotationComposer a) f,
  ) {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesTable,
          TypeRow,
          $$TypesTableFilterComposer,
          $$TypesTableOrderingComposer,
          $$TypesTableAnnotationComposer,
          $$TypesTableCreateCompanionBuilder,
          $$TypesTableUpdateCompanionBuilder,
          (TypeRow, $$TypesTableReferences),
          TypeRow,
          PrefetchHooks Function({bool digimonsRefs})
        > {
  $$TypesTableTableManager(_$AppDatabase db, $TypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypesCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypesCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TypesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({digimonsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (digimonsRefs) db.digimons],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (digimonsRefs)
                    await $_getPrefetchedData<TypeRow, $TypesTable, DigimonRow>(
                      currentTable: table,
                      referencedTable: $$TypesTableReferences
                          ._digimonsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TypesTableReferences(db, table, p0).digimonsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.typeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesTable,
      TypeRow,
      $$TypesTableFilterComposer,
      $$TypesTableOrderingComposer,
      $$TypesTableAnnotationComposer,
      $$TypesTableCreateCompanionBuilder,
      $$TypesTableUpdateCompanionBuilder,
      (TypeRow, $$TypesTableReferences),
      TypeRow,
      PrefetchHooks Function({bool digimonsRefs})
    >;
typedef $$ElementsTableCreateCompanionBuilder =
    ElementsCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });
typedef $$ElementsTableUpdateCompanionBuilder =
    ElementsCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });

final class $$ElementsTableReferences
    extends BaseReferences<_$AppDatabase, $ElementsTable, ElementRow> {
  $$ElementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DigimonsTable, List<DigimonRow>>
  _digimonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimons,
    aliasName: $_aliasNameGenerator(db.elements.id, db.digimons.elementId),
  );

  $$DigimonsTableProcessedTableManager get digimonsRefs {
    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.elementId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SkillsTable, List<SkillRow>> _skillsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.skills,
    aliasName: $_aliasNameGenerator(db.elements.id, db.skills.elementId),
  );

  $$SkillsTableProcessedTableManager get skillsRefs {
    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.elementId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_skillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ElementsTableFilterComposer
    extends Composer<_$AppDatabase, $ElementsTable> {
  $$ElementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> digimonsRefs(
    Expression<bool> Function($$DigimonsTableFilterComposer f) f,
  ) {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.elementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> skillsRefs(
    Expression<bool> Function($$SkillsTableFilterComposer f) f,
  ) {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.elementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElementsTableOrderingComposer
    extends Composer<_$AppDatabase, $ElementsTable> {
  $$ElementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ElementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElementsTable> {
  $$ElementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  Expression<T> digimonsRefs<T extends Object>(
    Expression<T> Function($$DigimonsTableAnnotationComposer a) f,
  ) {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.elementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> skillsRefs<T extends Object>(
    Expression<T> Function($$SkillsTableAnnotationComposer a) f,
  ) {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.elementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ElementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ElementsTable,
          ElementRow,
          $$ElementsTableFilterComposer,
          $$ElementsTableOrderingComposer,
          $$ElementsTableAnnotationComposer,
          $$ElementsTableCreateCompanionBuilder,
          $$ElementsTableUpdateCompanionBuilder,
          (ElementRow, $$ElementsTableReferences),
          ElementRow,
          PrefetchHooks Function({bool digimonsRefs, bool skillsRefs})
        > {
  $$ElementsTableTableManager(_$AppDatabase db, $ElementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ElementsCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ElementsCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ElementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({digimonsRefs = false, skillsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (digimonsRefs) db.digimons,
                if (skillsRefs) db.skills,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (digimonsRefs)
                    await $_getPrefetchedData<
                      ElementRow,
                      $ElementsTable,
                      DigimonRow
                    >(
                      currentTable: table,
                      referencedTable: $$ElementsTableReferences
                          ._digimonsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ElementsTableReferences(db, table, p0).digimonsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.elementId == item.id),
                      typedResults: items,
                    ),
                  if (skillsRefs)
                    await $_getPrefetchedData<
                      ElementRow,
                      $ElementsTable,
                      SkillRow
                    >(
                      currentTable: table,
                      referencedTable: $$ElementsTableReferences
                          ._skillsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ElementsTableReferences(db, table, p0).skillsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.elementId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ElementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ElementsTable,
      ElementRow,
      $$ElementsTableFilterComposer,
      $$ElementsTableOrderingComposer,
      $$ElementsTableAnnotationComposer,
      $$ElementsTableCreateCompanionBuilder,
      $$ElementsTableUpdateCompanionBuilder,
      (ElementRow, $$ElementsTableReferences),
      ElementRow,
      PrefetchHooks Function({bool digimonsRefs, bool skillsRefs})
    >;
typedef $$PersonalitiesTableCreateCompanionBuilder =
    PersonalitiesCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<String?> upStatJa,
      Value<String?> upStatZh,
      Value<String?> downStatJa,
      Value<String?> downStatZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });
typedef $$PersonalitiesTableUpdateCompanionBuilder =
    PersonalitiesCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<String?> upStatJa,
      Value<String?> upStatZh,
      Value<String?> downStatJa,
      Value<String?> downStatZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });

final class $$PersonalitiesTableReferences
    extends BaseReferences<_$AppDatabase, $PersonalitiesTable, PersonalityRow> {
  $$PersonalitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DigimonsTable, List<DigimonRow>>
  _digimonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimons,
    aliasName: $_aliasNameGenerator(
      db.personalities.id,
      db.digimons.personalityId,
    ),
  );

  $$DigimonsTableProcessedTableManager get digimonsRefs {
    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.personalityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $EvolutionConditionsTable,
    List<EvolutionConditionRow>
  >
  _evolutionConditionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.evolutionConditions,
        aliasName: $_aliasNameGenerator(
          db.personalities.id,
          db.evolutionConditions.personalityId,
        ),
      );

  $$EvolutionConditionsTableProcessedTableManager get evolutionConditionsRefs {
    final manager = $$EvolutionConditionsTableTableManager(
      $_db,
      $_db.evolutionConditions,
    ).filter((f) => f.personalityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _evolutionConditionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PersonalitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalitiesTable> {
  $$PersonalitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upStatJa => $composableBuilder(
    column: $table.upStatJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upStatZh => $composableBuilder(
    column: $table.upStatZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get downStatJa => $composableBuilder(
    column: $table.downStatJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get downStatZh => $composableBuilder(
    column: $table.downStatZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> digimonsRefs(
    Expression<bool> Function($$DigimonsTableFilterComposer f) f,
  ) {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.personalityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> evolutionConditionsRefs(
    Expression<bool> Function($$EvolutionConditionsTableFilterComposer f) f,
  ) {
    final $$EvolutionConditionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evolutionConditions,
      getReferencedColumn: (t) => t.personalityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvolutionConditionsTableFilterComposer(
            $db: $db,
            $table: $db.evolutionConditions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonalitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalitiesTable> {
  $$PersonalitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upStatJa => $composableBuilder(
    column: $table.upStatJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upStatZh => $composableBuilder(
    column: $table.upStatZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downStatJa => $composableBuilder(
    column: $table.downStatJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downStatZh => $composableBuilder(
    column: $table.downStatZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalitiesTable> {
  $$PersonalitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<String> get upStatJa =>
      $composableBuilder(column: $table.upStatJa, builder: (column) => column);

  GeneratedColumn<String> get upStatZh =>
      $composableBuilder(column: $table.upStatZh, builder: (column) => column);

  GeneratedColumn<String> get downStatJa => $composableBuilder(
    column: $table.downStatJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get downStatZh => $composableBuilder(
    column: $table.downStatZh,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => column,
  );

  Expression<T> digimonsRefs<T extends Object>(
    Expression<T> Function($$DigimonsTableAnnotationComposer a) f,
  ) {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.personalityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> evolutionConditionsRefs<T extends Object>(
    Expression<T> Function($$EvolutionConditionsTableAnnotationComposer a) f,
  ) {
    final $$EvolutionConditionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.evolutionConditions,
          getReferencedColumn: (t) => t.personalityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionConditionsTableAnnotationComposer(
                $db: $db,
                $table: $db.evolutionConditions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PersonalitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalitiesTable,
          PersonalityRow,
          $$PersonalitiesTableFilterComposer,
          $$PersonalitiesTableOrderingComposer,
          $$PersonalitiesTableAnnotationComposer,
          $$PersonalitiesTableCreateCompanionBuilder,
          $$PersonalitiesTableUpdateCompanionBuilder,
          (PersonalityRow, $$PersonalitiesTableReferences),
          PersonalityRow,
          PrefetchHooks Function({
            bool digimonsRefs,
            bool evolutionConditionsRefs,
          })
        > {
  $$PersonalitiesTableTableManager(_$AppDatabase db, $PersonalitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> upStatJa = const Value.absent(),
                Value<String?> upStatZh = const Value.absent(),
                Value<String?> downStatJa = const Value.absent(),
                Value<String?> downStatZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonalitiesCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                upStatJa: upStatJa,
                upStatZh: upStatZh,
                downStatJa: downStatJa,
                downStatZh: downStatZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<String?> upStatJa = const Value.absent(),
                Value<String?> upStatZh = const Value.absent(),
                Value<String?> downStatJa = const Value.absent(),
                Value<String?> downStatZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonalitiesCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                upStatJa: upStatJa,
                upStatZh: upStatZh,
                downStatJa: downStatJa,
                downStatZh: downStatZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonalitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({digimonsRefs = false, evolutionConditionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (digimonsRefs) db.digimons,
                    if (evolutionConditionsRefs) db.evolutionConditions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (digimonsRefs)
                        await $_getPrefetchedData<
                          PersonalityRow,
                          $PersonalitiesTable,
                          DigimonRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonalitiesTableReferences
                              ._digimonsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonalitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).digimonsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personalityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (evolutionConditionsRefs)
                        await $_getPrefetchedData<
                          PersonalityRow,
                          $PersonalitiesTable,
                          EvolutionConditionRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonalitiesTableReferences
                              ._evolutionConditionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonalitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).evolutionConditionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personalityId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PersonalitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalitiesTable,
      PersonalityRow,
      $$PersonalitiesTableFilterComposer,
      $$PersonalitiesTableOrderingComposer,
      $$PersonalitiesTableAnnotationComposer,
      $$PersonalitiesTableCreateCompanionBuilder,
      $$PersonalitiesTableUpdateCompanionBuilder,
      (PersonalityRow, $$PersonalitiesTableReferences),
      PersonalityRow,
      PrefetchHooks Function({bool digimonsRefs, bool evolutionConditionsRefs})
    >;
typedef $$DigimonsTableCreateCompanionBuilder =
    DigimonsCompanion Function({
      required String id,
      Value<int?> dexNumber,
      required String nameJa,
      Value<String?> nameZh,
      Value<String?> nameEn,
      Value<String?> stageId,
      Value<String?> attributeId,
      Value<String?> typeId,
      Value<String?> elementId,
      Value<String?> personalityId,
      Value<bool?> canDigiride,
      Value<String?> dlcPack,
      Value<int?> maxHp,
      Value<int?> maxSp,
      Value<int?> maxAtk,
      Value<int?> maxDef,
      Value<int?> maxInt,
      Value<int?> maxMen,
      Value<int?> maxSpd,
      Value<String?> imagePath,
      Value<String?> sourceUrlJa,
      Value<String?> sourceUrlZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });
typedef $$DigimonsTableUpdateCompanionBuilder =
    DigimonsCompanion Function({
      Value<String> id,
      Value<int?> dexNumber,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<String?> nameEn,
      Value<String?> stageId,
      Value<String?> attributeId,
      Value<String?> typeId,
      Value<String?> elementId,
      Value<String?> personalityId,
      Value<bool?> canDigiride,
      Value<String?> dlcPack,
      Value<int?> maxHp,
      Value<int?> maxSp,
      Value<int?> maxAtk,
      Value<int?> maxDef,
      Value<int?> maxInt,
      Value<int?> maxMen,
      Value<int?> maxSpd,
      Value<String?> imagePath,
      Value<String?> sourceUrlJa,
      Value<String?> sourceUrlZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });

final class $$DigimonsTableReferences
    extends BaseReferences<_$AppDatabase, $DigimonsTable, DigimonRow> {
  $$DigimonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StagesTable _stageIdTable(_$AppDatabase db) => db.stages.createAlias(
    $_aliasNameGenerator(db.digimons.stageId, db.stages.id),
  );

  $$StagesTableProcessedTableManager? get stageId {
    final $_column = $_itemColumn<String>('stage_id');
    if ($_column == null) return null;
    final manager = $$StagesTableTableManager(
      $_db,
      $_db.stages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AttributesTable _attributeIdTable(_$AppDatabase db) =>
      db.attributes.createAlias(
        $_aliasNameGenerator(db.digimons.attributeId, db.attributes.id),
      );

  $$AttributesTableProcessedTableManager? get attributeId {
    final $_column = $_itemColumn<String>('attribute_id');
    if ($_column == null) return null;
    final manager = $$AttributesTableTableManager(
      $_db,
      $_db.attributes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attributeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTable _typeIdTable(_$AppDatabase db) => db.types.createAlias(
    $_aliasNameGenerator(db.digimons.typeId, db.types.id),
  );

  $$TypesTableProcessedTableManager? get typeId {
    final $_column = $_itemColumn<String>('type_id');
    if ($_column == null) return null;
    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ElementsTable _elementIdTable(_$AppDatabase db) => db.elements
      .createAlias($_aliasNameGenerator(db.digimons.elementId, db.elements.id));

  $$ElementsTableProcessedTableManager? get elementId {
    final $_column = $_itemColumn<String>('element_id');
    if ($_column == null) return null;
    final manager = $$ElementsTableTableManager(
      $_db,
      $_db.elements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_elementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonalitiesTable _personalityIdTable(_$AppDatabase db) =>
      db.personalities.createAlias(
        $_aliasNameGenerator(db.digimons.personalityId, db.personalities.id),
      );

  $$PersonalitiesTableProcessedTableManager? get personalityId {
    final $_column = $_itemColumn<String>('personality_id');
    if ($_column == null) return null;
    final manager = $$PersonalitiesTableTableManager(
      $_db,
      $_db.personalities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personalityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $EvolutionConditionsTable,
    List<EvolutionConditionRow>
  >
  _evolutionConditionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.evolutionConditions,
        aliasName: $_aliasNameGenerator(
          db.digimons.id,
          db.evolutionConditions.digimonId,
        ),
      );

  $$EvolutionConditionsTableProcessedTableManager get evolutionConditionsRefs {
    final manager = $$EvolutionConditionsTableTableManager(
      $_db,
      $_db.evolutionConditions,
    ).filter((f) => f.digimonId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _evolutionConditionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DigimonSkillsTable, List<DigimonSkillRow>>
  _digimonSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimonSkills,
    aliasName: $_aliasNameGenerator(db.digimons.id, db.digimonSkills.digimonId),
  );

  $$DigimonSkillsTableProcessedTableManager get digimonSkillsRefs {
    final manager = $$DigimonSkillsTableTableManager(
      $_db,
      $_db.digimonSkills,
    ).filter((f) => f.digimonId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonSkillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DigimonsTableFilterComposer
    extends Composer<_$AppDatabase, $DigimonsTable> {
  $$DigimonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dexNumber => $composableBuilder(
    column: $table.dexNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canDigiride => $composableBuilder(
    column: $table.canDigiride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dlcPack => $composableBuilder(
    column: $table.dlcPack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxHp => $composableBuilder(
    column: $table.maxHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxSp => $composableBuilder(
    column: $table.maxSp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAtk => $composableBuilder(
    column: $table.maxAtk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxDef => $composableBuilder(
    column: $table.maxDef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxInt => $composableBuilder(
    column: $table.maxInt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxMen => $composableBuilder(
    column: $table.maxMen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxSpd => $composableBuilder(
    column: $table.maxSpd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrlJa => $composableBuilder(
    column: $table.sourceUrlJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrlZh => $composableBuilder(
    column: $table.sourceUrlZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnFilters(column),
  );

  $$StagesTableFilterComposer get stageId {
    final $$StagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stageId,
      referencedTable: $db.stages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StagesTableFilterComposer(
            $db: $db,
            $table: $db.stages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AttributesTableFilterComposer get attributeId {
    final $$AttributesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attributeId,
      referencedTable: $db.attributes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttributesTableFilterComposer(
            $db: $db,
            $table: $db.attributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableFilterComposer get typeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableFilterComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ElementsTableFilterComposer get elementId {
    final $$ElementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elementId,
      referencedTable: $db.elements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElementsTableFilterComposer(
            $db: $db,
            $table: $db.elements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonalitiesTableFilterComposer get personalityId {
    final $$PersonalitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personalityId,
      referencedTable: $db.personalities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalitiesTableFilterComposer(
            $db: $db,
            $table: $db.personalities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> evolutionConditionsRefs(
    Expression<bool> Function($$EvolutionConditionsTableFilterComposer f) f,
  ) {
    final $$EvolutionConditionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evolutionConditions,
      getReferencedColumn: (t) => t.digimonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvolutionConditionsTableFilterComposer(
            $db: $db,
            $table: $db.evolutionConditions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> digimonSkillsRefs(
    Expression<bool> Function($$DigimonSkillsTableFilterComposer f) f,
  ) {
    final $$DigimonSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimonSkills,
      getReferencedColumn: (t) => t.digimonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonSkillsTableFilterComposer(
            $db: $db,
            $table: $db.digimonSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DigimonsTableOrderingComposer
    extends Composer<_$AppDatabase, $DigimonsTable> {
  $$DigimonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dexNumber => $composableBuilder(
    column: $table.dexNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canDigiride => $composableBuilder(
    column: $table.canDigiride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dlcPack => $composableBuilder(
    column: $table.dlcPack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxHp => $composableBuilder(
    column: $table.maxHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxSp => $composableBuilder(
    column: $table.maxSp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAtk => $composableBuilder(
    column: $table.maxAtk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxDef => $composableBuilder(
    column: $table.maxDef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxInt => $composableBuilder(
    column: $table.maxInt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxMen => $composableBuilder(
    column: $table.maxMen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxSpd => $composableBuilder(
    column: $table.maxSpd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrlJa => $composableBuilder(
    column: $table.sourceUrlJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrlZh => $composableBuilder(
    column: $table.sourceUrlZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnOrderings(column),
  );

  $$StagesTableOrderingComposer get stageId {
    final $$StagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stageId,
      referencedTable: $db.stages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StagesTableOrderingComposer(
            $db: $db,
            $table: $db.stages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AttributesTableOrderingComposer get attributeId {
    final $$AttributesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attributeId,
      referencedTable: $db.attributes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttributesTableOrderingComposer(
            $db: $db,
            $table: $db.attributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableOrderingComposer get typeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableOrderingComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ElementsTableOrderingComposer get elementId {
    final $$ElementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elementId,
      referencedTable: $db.elements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElementsTableOrderingComposer(
            $db: $db,
            $table: $db.elements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonalitiesTableOrderingComposer get personalityId {
    final $$PersonalitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personalityId,
      referencedTable: $db.personalities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalitiesTableOrderingComposer(
            $db: $db,
            $table: $db.personalities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DigimonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DigimonsTable> {
  $$DigimonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dexNumber =>
      $composableBuilder(column: $table.dexNumber, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<bool> get canDigiride => $composableBuilder(
    column: $table.canDigiride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dlcPack =>
      $composableBuilder(column: $table.dlcPack, builder: (column) => column);

  GeneratedColumn<int> get maxHp =>
      $composableBuilder(column: $table.maxHp, builder: (column) => column);

  GeneratedColumn<int> get maxSp =>
      $composableBuilder(column: $table.maxSp, builder: (column) => column);

  GeneratedColumn<int> get maxAtk =>
      $composableBuilder(column: $table.maxAtk, builder: (column) => column);

  GeneratedColumn<int> get maxDef =>
      $composableBuilder(column: $table.maxDef, builder: (column) => column);

  GeneratedColumn<int> get maxInt =>
      $composableBuilder(column: $table.maxInt, builder: (column) => column);

  GeneratedColumn<int> get maxMen =>
      $composableBuilder(column: $table.maxMen, builder: (column) => column);

  GeneratedColumn<int> get maxSpd =>
      $composableBuilder(column: $table.maxSpd, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get sourceUrlJa => $composableBuilder(
    column: $table.sourceUrlJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceUrlZh => $composableBuilder(
    column: $table.sourceUrlZh,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => column,
  );

  $$StagesTableAnnotationComposer get stageId {
    final $$StagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stageId,
      referencedTable: $db.stages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StagesTableAnnotationComposer(
            $db: $db,
            $table: $db.stages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AttributesTableAnnotationComposer get attributeId {
    final $$AttributesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attributeId,
      referencedTable: $db.attributes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttributesTableAnnotationComposer(
            $db: $db,
            $table: $db.attributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableAnnotationComposer get typeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableAnnotationComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ElementsTableAnnotationComposer get elementId {
    final $$ElementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elementId,
      referencedTable: $db.elements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElementsTableAnnotationComposer(
            $db: $db,
            $table: $db.elements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonalitiesTableAnnotationComposer get personalityId {
    final $$PersonalitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personalityId,
      referencedTable: $db.personalities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.personalities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> evolutionConditionsRefs<T extends Object>(
    Expression<T> Function($$EvolutionConditionsTableAnnotationComposer a) f,
  ) {
    final $$EvolutionConditionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.evolutionConditions,
          getReferencedColumn: (t) => t.digimonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionConditionsTableAnnotationComposer(
                $db: $db,
                $table: $db.evolutionConditions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> digimonSkillsRefs<T extends Object>(
    Expression<T> Function($$DigimonSkillsTableAnnotationComposer a) f,
  ) {
    final $$DigimonSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimonSkills,
      getReferencedColumn: (t) => t.digimonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimonSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DigimonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DigimonsTable,
          DigimonRow,
          $$DigimonsTableFilterComposer,
          $$DigimonsTableOrderingComposer,
          $$DigimonsTableAnnotationComposer,
          $$DigimonsTableCreateCompanionBuilder,
          $$DigimonsTableUpdateCompanionBuilder,
          (DigimonRow, $$DigimonsTableReferences),
          DigimonRow,
          PrefetchHooks Function({
            bool stageId,
            bool attributeId,
            bool typeId,
            bool elementId,
            bool personalityId,
            bool evolutionConditionsRefs,
            bool digimonSkillsRefs,
          })
        > {
  $$DigimonsTableTableManager(_$AppDatabase db, $DigimonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DigimonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DigimonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DigimonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> dexNumber = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> stageId = const Value.absent(),
                Value<String?> attributeId = const Value.absent(),
                Value<String?> typeId = const Value.absent(),
                Value<String?> elementId = const Value.absent(),
                Value<String?> personalityId = const Value.absent(),
                Value<bool?> canDigiride = const Value.absent(),
                Value<String?> dlcPack = const Value.absent(),
                Value<int?> maxHp = const Value.absent(),
                Value<int?> maxSp = const Value.absent(),
                Value<int?> maxAtk = const Value.absent(),
                Value<int?> maxDef = const Value.absent(),
                Value<int?> maxInt = const Value.absent(),
                Value<int?> maxMen = const Value.absent(),
                Value<int?> maxSpd = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> sourceUrlJa = const Value.absent(),
                Value<String?> sourceUrlZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DigimonsCompanion(
                id: id,
                dexNumber: dexNumber,
                nameJa: nameJa,
                nameZh: nameZh,
                nameEn: nameEn,
                stageId: stageId,
                attributeId: attributeId,
                typeId: typeId,
                elementId: elementId,
                personalityId: personalityId,
                canDigiride: canDigiride,
                dlcPack: dlcPack,
                maxHp: maxHp,
                maxSp: maxSp,
                maxAtk: maxAtk,
                maxDef: maxDef,
                maxInt: maxInt,
                maxMen: maxMen,
                maxSpd: maxSpd,
                imagePath: imagePath,
                sourceUrlJa: sourceUrlJa,
                sourceUrlZh: sourceUrlZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> dexNumber = const Value.absent(),
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> stageId = const Value.absent(),
                Value<String?> attributeId = const Value.absent(),
                Value<String?> typeId = const Value.absent(),
                Value<String?> elementId = const Value.absent(),
                Value<String?> personalityId = const Value.absent(),
                Value<bool?> canDigiride = const Value.absent(),
                Value<String?> dlcPack = const Value.absent(),
                Value<int?> maxHp = const Value.absent(),
                Value<int?> maxSp = const Value.absent(),
                Value<int?> maxAtk = const Value.absent(),
                Value<int?> maxDef = const Value.absent(),
                Value<int?> maxInt = const Value.absent(),
                Value<int?> maxMen = const Value.absent(),
                Value<int?> maxSpd = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> sourceUrlJa = const Value.absent(),
                Value<String?> sourceUrlZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DigimonsCompanion.insert(
                id: id,
                dexNumber: dexNumber,
                nameJa: nameJa,
                nameZh: nameZh,
                nameEn: nameEn,
                stageId: stageId,
                attributeId: attributeId,
                typeId: typeId,
                elementId: elementId,
                personalityId: personalityId,
                canDigiride: canDigiride,
                dlcPack: dlcPack,
                maxHp: maxHp,
                maxSp: maxSp,
                maxAtk: maxAtk,
                maxDef: maxDef,
                maxInt: maxInt,
                maxMen: maxMen,
                maxSpd: maxSpd,
                imagePath: imagePath,
                sourceUrlJa: sourceUrlJa,
                sourceUrlZh: sourceUrlZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DigimonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                stageId = false,
                attributeId = false,
                typeId = false,
                elementId = false,
                personalityId = false,
                evolutionConditionsRefs = false,
                digimonSkillsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (evolutionConditionsRefs) db.evolutionConditions,
                    if (digimonSkillsRefs) db.digimonSkills,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (stageId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.stageId,
                                    referencedTable: $$DigimonsTableReferences
                                        ._stageIdTable(db),
                                    referencedColumn: $$DigimonsTableReferences
                                        ._stageIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (attributeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.attributeId,
                                    referencedTable: $$DigimonsTableReferences
                                        ._attributeIdTable(db),
                                    referencedColumn: $$DigimonsTableReferences
                                        ._attributeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (typeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.typeId,
                                    referencedTable: $$DigimonsTableReferences
                                        ._typeIdTable(db),
                                    referencedColumn: $$DigimonsTableReferences
                                        ._typeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (elementId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.elementId,
                                    referencedTable: $$DigimonsTableReferences
                                        ._elementIdTable(db),
                                    referencedColumn: $$DigimonsTableReferences
                                        ._elementIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (personalityId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.personalityId,
                                    referencedTable: $$DigimonsTableReferences
                                        ._personalityIdTable(db),
                                    referencedColumn: $$DigimonsTableReferences
                                        ._personalityIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (evolutionConditionsRefs)
                        await $_getPrefetchedData<
                          DigimonRow,
                          $DigimonsTable,
                          EvolutionConditionRow
                        >(
                          currentTable: table,
                          referencedTable: $$DigimonsTableReferences
                              ._evolutionConditionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DigimonsTableReferences(
                                db,
                                table,
                                p0,
                              ).evolutionConditionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.digimonId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (digimonSkillsRefs)
                        await $_getPrefetchedData<
                          DigimonRow,
                          $DigimonsTable,
                          DigimonSkillRow
                        >(
                          currentTable: table,
                          referencedTable: $$DigimonsTableReferences
                              ._digimonSkillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DigimonsTableReferences(
                                db,
                                table,
                                p0,
                              ).digimonSkillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.digimonId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DigimonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DigimonsTable,
      DigimonRow,
      $$DigimonsTableFilterComposer,
      $$DigimonsTableOrderingComposer,
      $$DigimonsTableAnnotationComposer,
      $$DigimonsTableCreateCompanionBuilder,
      $$DigimonsTableUpdateCompanionBuilder,
      (DigimonRow, $$DigimonsTableReferences),
      DigimonRow,
      PrefetchHooks Function({
        bool stageId,
        bool attributeId,
        bool typeId,
        bool elementId,
        bool personalityId,
        bool evolutionConditionsRefs,
        bool digimonSkillsRefs,
      })
    >;
typedef $$EvolutionsTableCreateCompanionBuilder =
    EvolutionsCompanion Function({
      Value<int> id,
      required String fromId,
      required String toId,
      Value<String> direction,
      Value<String?> conditionTextJa,
      Value<String?> conditionTextZh,
    });
typedef $$EvolutionsTableUpdateCompanionBuilder =
    EvolutionsCompanion Function({
      Value<int> id,
      Value<String> fromId,
      Value<String> toId,
      Value<String> direction,
      Value<String?> conditionTextJa,
      Value<String?> conditionTextZh,
    });

final class $$EvolutionsTableReferences
    extends BaseReferences<_$AppDatabase, $EvolutionsTable, EvolutionRow> {
  $$EvolutionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DigimonsTable _fromIdTable(_$AppDatabase db) => db.digimons
      .createAlias($_aliasNameGenerator(db.evolutions.fromId, db.digimons.id));

  $$DigimonsTableProcessedTableManager get fromId {
    final $_column = $_itemColumn<String>('from_id')!;

    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DigimonsTable _toIdTable(_$AppDatabase db) => db.digimons.createAlias(
    $_aliasNameGenerator(db.evolutions.toId, db.digimons.id),
  );

  $$DigimonsTableProcessedTableManager get toId {
    final $_column = $_itemColumn<String>('to_id')!;

    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $EvolutionConditionsTable,
    List<EvolutionConditionRow>
  >
  _evolutionConditionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.evolutionConditions,
        aliasName: $_aliasNameGenerator(
          db.evolutions.id,
          db.evolutionConditions.evolutionId,
        ),
      );

  $$EvolutionConditionsTableProcessedTableManager get evolutionConditionsRefs {
    final manager = $$EvolutionConditionsTableTableManager(
      $_db,
      $_db.evolutionConditions,
    ).filter((f) => f.evolutionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _evolutionConditionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EvolutionsTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionTextJa => $composableBuilder(
    column: $table.conditionTextJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionTextZh => $composableBuilder(
    column: $table.conditionTextZh,
    builder: (column) => ColumnFilters(column),
  );

  $$DigimonsTableFilterComposer get fromId {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DigimonsTableFilterComposer get toId {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> evolutionConditionsRefs(
    Expression<bool> Function($$EvolutionConditionsTableFilterComposer f) f,
  ) {
    final $$EvolutionConditionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evolutionConditions,
      getReferencedColumn: (t) => t.evolutionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvolutionConditionsTableFilterComposer(
            $db: $db,
            $table: $db.evolutionConditions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EvolutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionTextJa => $composableBuilder(
    column: $table.conditionTextJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionTextZh => $composableBuilder(
    column: $table.conditionTextZh,
    builder: (column) => ColumnOrderings(column),
  );

  $$DigimonsTableOrderingComposer get fromId {
    final $$DigimonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableOrderingComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DigimonsTableOrderingComposer get toId {
    final $$DigimonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableOrderingComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionsTable> {
  $$EvolutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get conditionTextJa => $composableBuilder(
    column: $table.conditionTextJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditionTextZh => $composableBuilder(
    column: $table.conditionTextZh,
    builder: (column) => column,
  );

  $$DigimonsTableAnnotationComposer get fromId {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DigimonsTableAnnotationComposer get toId {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> evolutionConditionsRefs<T extends Object>(
    Expression<T> Function($$EvolutionConditionsTableAnnotationComposer a) f,
  ) {
    final $$EvolutionConditionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.evolutionConditions,
          getReferencedColumn: (t) => t.evolutionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EvolutionConditionsTableAnnotationComposer(
                $db: $db,
                $table: $db.evolutionConditions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EvolutionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionsTable,
          EvolutionRow,
          $$EvolutionsTableFilterComposer,
          $$EvolutionsTableOrderingComposer,
          $$EvolutionsTableAnnotationComposer,
          $$EvolutionsTableCreateCompanionBuilder,
          $$EvolutionsTableUpdateCompanionBuilder,
          (EvolutionRow, $$EvolutionsTableReferences),
          EvolutionRow,
          PrefetchHooks Function({
            bool fromId,
            bool toId,
            bool evolutionConditionsRefs,
          })
        > {
  $$EvolutionsTableTableManager(_$AppDatabase db, $EvolutionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvolutionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvolutionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fromId = const Value.absent(),
                Value<String> toId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String?> conditionTextJa = const Value.absent(),
                Value<String?> conditionTextZh = const Value.absent(),
              }) => EvolutionsCompanion(
                id: id,
                fromId: fromId,
                toId: toId,
                direction: direction,
                conditionTextJa: conditionTextJa,
                conditionTextZh: conditionTextZh,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fromId,
                required String toId,
                Value<String> direction = const Value.absent(),
                Value<String?> conditionTextJa = const Value.absent(),
                Value<String?> conditionTextZh = const Value.absent(),
              }) => EvolutionsCompanion.insert(
                id: id,
                fromId: fromId,
                toId: toId,
                direction: direction,
                conditionTextJa: conditionTextJa,
                conditionTextZh: conditionTextZh,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EvolutionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fromId = false,
                toId = false,
                evolutionConditionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (evolutionConditionsRefs) db.evolutionConditions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fromId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromId,
                                    referencedTable: $$EvolutionsTableReferences
                                        ._fromIdTable(db),
                                    referencedColumn:
                                        $$EvolutionsTableReferences
                                            ._fromIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (toId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.toId,
                                    referencedTable: $$EvolutionsTableReferences
                                        ._toIdTable(db),
                                    referencedColumn:
                                        $$EvolutionsTableReferences
                                            ._toIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (evolutionConditionsRefs)
                        await $_getPrefetchedData<
                          EvolutionRow,
                          $EvolutionsTable,
                          EvolutionConditionRow
                        >(
                          currentTable: table,
                          referencedTable: $$EvolutionsTableReferences
                              ._evolutionConditionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EvolutionsTableReferences(
                                db,
                                table,
                                p0,
                              ).evolutionConditionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.evolutionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EvolutionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionsTable,
      EvolutionRow,
      $$EvolutionsTableFilterComposer,
      $$EvolutionsTableOrderingComposer,
      $$EvolutionsTableAnnotationComposer,
      $$EvolutionsTableCreateCompanionBuilder,
      $$EvolutionsTableUpdateCompanionBuilder,
      (EvolutionRow, $$EvolutionsTableReferences),
      EvolutionRow,
      PrefetchHooks Function({
        bool fromId,
        bool toId,
        bool evolutionConditionsRefs,
      })
    >;
typedef $$EvolutionConditionsTableCreateCompanionBuilder =
    EvolutionConditionsCompanion Function({
      Value<int> id,
      required int evolutionId,
      required String kind,
      Value<String?> statId,
      Value<int?> threshold,
      Value<String?> digimonId,
      Value<String?> personalityId,
      Value<String?> textJa,
      Value<String?> textZh,
    });
typedef $$EvolutionConditionsTableUpdateCompanionBuilder =
    EvolutionConditionsCompanion Function({
      Value<int> id,
      Value<int> evolutionId,
      Value<String> kind,
      Value<String?> statId,
      Value<int?> threshold,
      Value<String?> digimonId,
      Value<String?> personalityId,
      Value<String?> textJa,
      Value<String?> textZh,
    });

final class $$EvolutionConditionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EvolutionConditionsTable,
          EvolutionConditionRow
        > {
  $$EvolutionConditionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EvolutionsTable _evolutionIdTable(_$AppDatabase db) =>
      db.evolutions.createAlias(
        $_aliasNameGenerator(
          db.evolutionConditions.evolutionId,
          db.evolutions.id,
        ),
      );

  $$EvolutionsTableProcessedTableManager get evolutionId {
    final $_column = $_itemColumn<int>('evolution_id')!;

    final manager = $$EvolutionsTableTableManager(
      $_db,
      $_db.evolutions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_evolutionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DigimonsTable _digimonIdTable(_$AppDatabase db) =>
      db.digimons.createAlias(
        $_aliasNameGenerator(db.evolutionConditions.digimonId, db.digimons.id),
      );

  $$DigimonsTableProcessedTableManager? get digimonId {
    final $_column = $_itemColumn<String>('digimon_id');
    if ($_column == null) return null;
    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_digimonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonalitiesTable _personalityIdTable(_$AppDatabase db) =>
      db.personalities.createAlias(
        $_aliasNameGenerator(
          db.evolutionConditions.personalityId,
          db.personalities.id,
        ),
      );

  $$PersonalitiesTableProcessedTableManager? get personalityId {
    final $_column = $_itemColumn<String>('personality_id');
    if ($_column == null) return null;
    final manager = $$PersonalitiesTableTableManager(
      $_db,
      $_db.personalities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personalityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EvolutionConditionsTableFilterComposer
    extends Composer<_$AppDatabase, $EvolutionConditionsTable> {
  $$EvolutionConditionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statId => $composableBuilder(
    column: $table.statId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get threshold => $composableBuilder(
    column: $table.threshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textJa => $composableBuilder(
    column: $table.textJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnFilters(column),
  );

  $$EvolutionsTableFilterComposer get evolutionId {
    final $$EvolutionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.evolutionId,
      referencedTable: $db.evolutions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvolutionsTableFilterComposer(
            $db: $db,
            $table: $db.evolutions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DigimonsTableFilterComposer get digimonId {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.digimonId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonalitiesTableFilterComposer get personalityId {
    final $$PersonalitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personalityId,
      referencedTable: $db.personalities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalitiesTableFilterComposer(
            $db: $db,
            $table: $db.personalities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionConditionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EvolutionConditionsTable> {
  $$EvolutionConditionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statId => $composableBuilder(
    column: $table.statId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get threshold => $composableBuilder(
    column: $table.threshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textJa => $composableBuilder(
    column: $table.textJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textZh => $composableBuilder(
    column: $table.textZh,
    builder: (column) => ColumnOrderings(column),
  );

  $$EvolutionsTableOrderingComposer get evolutionId {
    final $$EvolutionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.evolutionId,
      referencedTable: $db.evolutions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvolutionsTableOrderingComposer(
            $db: $db,
            $table: $db.evolutions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DigimonsTableOrderingComposer get digimonId {
    final $$DigimonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.digimonId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableOrderingComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonalitiesTableOrderingComposer get personalityId {
    final $$PersonalitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personalityId,
      referencedTable: $db.personalities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalitiesTableOrderingComposer(
            $db: $db,
            $table: $db.personalities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionConditionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvolutionConditionsTable> {
  $$EvolutionConditionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get statId =>
      $composableBuilder(column: $table.statId, builder: (column) => column);

  GeneratedColumn<int> get threshold =>
      $composableBuilder(column: $table.threshold, builder: (column) => column);

  GeneratedColumn<String> get textJa =>
      $composableBuilder(column: $table.textJa, builder: (column) => column);

  GeneratedColumn<String> get textZh =>
      $composableBuilder(column: $table.textZh, builder: (column) => column);

  $$EvolutionsTableAnnotationComposer get evolutionId {
    final $$EvolutionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.evolutionId,
      referencedTable: $db.evolutions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvolutionsTableAnnotationComposer(
            $db: $db,
            $table: $db.evolutions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DigimonsTableAnnotationComposer get digimonId {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.digimonId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonalitiesTableAnnotationComposer get personalityId {
    final $$PersonalitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personalityId,
      referencedTable: $db.personalities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.personalities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvolutionConditionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvolutionConditionsTable,
          EvolutionConditionRow,
          $$EvolutionConditionsTableFilterComposer,
          $$EvolutionConditionsTableOrderingComposer,
          $$EvolutionConditionsTableAnnotationComposer,
          $$EvolutionConditionsTableCreateCompanionBuilder,
          $$EvolutionConditionsTableUpdateCompanionBuilder,
          (EvolutionConditionRow, $$EvolutionConditionsTableReferences),
          EvolutionConditionRow,
          PrefetchHooks Function({
            bool evolutionId,
            bool digimonId,
            bool personalityId,
          })
        > {
  $$EvolutionConditionsTableTableManager(
    _$AppDatabase db,
    $EvolutionConditionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvolutionConditionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvolutionConditionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EvolutionConditionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> evolutionId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> statId = const Value.absent(),
                Value<int?> threshold = const Value.absent(),
                Value<String?> digimonId = const Value.absent(),
                Value<String?> personalityId = const Value.absent(),
                Value<String?> textJa = const Value.absent(),
                Value<String?> textZh = const Value.absent(),
              }) => EvolutionConditionsCompanion(
                id: id,
                evolutionId: evolutionId,
                kind: kind,
                statId: statId,
                threshold: threshold,
                digimonId: digimonId,
                personalityId: personalityId,
                textJa: textJa,
                textZh: textZh,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int evolutionId,
                required String kind,
                Value<String?> statId = const Value.absent(),
                Value<int?> threshold = const Value.absent(),
                Value<String?> digimonId = const Value.absent(),
                Value<String?> personalityId = const Value.absent(),
                Value<String?> textJa = const Value.absent(),
                Value<String?> textZh = const Value.absent(),
              }) => EvolutionConditionsCompanion.insert(
                id: id,
                evolutionId: evolutionId,
                kind: kind,
                statId: statId,
                threshold: threshold,
                digimonId: digimonId,
                personalityId: personalityId,
                textJa: textJa,
                textZh: textZh,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EvolutionConditionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                evolutionId = false,
                digimonId = false,
                personalityId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (evolutionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.evolutionId,
                                    referencedTable:
                                        $$EvolutionConditionsTableReferences
                                            ._evolutionIdTable(db),
                                    referencedColumn:
                                        $$EvolutionConditionsTableReferences
                                            ._evolutionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (digimonId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.digimonId,
                                    referencedTable:
                                        $$EvolutionConditionsTableReferences
                                            ._digimonIdTable(db),
                                    referencedColumn:
                                        $$EvolutionConditionsTableReferences
                                            ._digimonIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (personalityId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.personalityId,
                                    referencedTable:
                                        $$EvolutionConditionsTableReferences
                                            ._personalityIdTable(db),
                                    referencedColumn:
                                        $$EvolutionConditionsTableReferences
                                            ._personalityIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EvolutionConditionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvolutionConditionsTable,
      EvolutionConditionRow,
      $$EvolutionConditionsTableFilterComposer,
      $$EvolutionConditionsTableOrderingComposer,
      $$EvolutionConditionsTableAnnotationComposer,
      $$EvolutionConditionsTableCreateCompanionBuilder,
      $$EvolutionConditionsTableUpdateCompanionBuilder,
      (EvolutionConditionRow, $$EvolutionConditionsTableReferences),
      EvolutionConditionRow,
      PrefetchHooks Function({
        bool evolutionId,
        bool digimonId,
        bool personalityId,
      })
    >;
typedef $$SkillCategoriesTableCreateCompanionBuilder =
    SkillCategoriesCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });
typedef $$SkillCategoriesTableUpdateCompanionBuilder =
    SkillCategoriesCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<int> rowid,
    });

final class $$SkillCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $SkillCategoriesTable, SkillCategoryRow> {
  $$SkillCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SkillsTable, List<SkillRow>> _skillsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.skills,
    aliasName: $_aliasNameGenerator(
      db.skillCategories.id,
      db.skills.categoryId,
    ),
  );

  $$SkillsTableProcessedTableManager get skillsRefs {
    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_skillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkillCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $SkillCategoriesTable> {
  $$SkillCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> skillsRefs(
    Expression<bool> Function($$SkillsTableFilterComposer f) f,
  ) {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillCategoriesTable> {
  $$SkillCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillCategoriesTable> {
  $$SkillCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  Expression<T> skillsRefs<T extends Object>(
    Expression<T> Function($$SkillsTableAnnotationComposer a) f,
  ) {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillCategoriesTable,
          SkillCategoryRow,
          $$SkillCategoriesTableFilterComposer,
          $$SkillCategoriesTableOrderingComposer,
          $$SkillCategoriesTableAnnotationComposer,
          $$SkillCategoriesTableCreateCompanionBuilder,
          $$SkillCategoriesTableUpdateCompanionBuilder,
          (SkillCategoryRow, $$SkillCategoriesTableReferences),
          SkillCategoryRow,
          PrefetchHooks Function({bool skillsRefs})
        > {
  $$SkillCategoriesTableTableManager(
    _$AppDatabase db,
    $SkillCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillCategoriesCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillCategoriesCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkillCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({skillsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (skillsRefs) db.skills],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (skillsRefs)
                    await $_getPrefetchedData<
                      SkillCategoryRow,
                      $SkillCategoriesTable,
                      SkillRow
                    >(
                      currentTable: table,
                      referencedTable: $$SkillCategoriesTableReferences
                          ._skillsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SkillCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).skillsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SkillCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillCategoriesTable,
      SkillCategoryRow,
      $$SkillCategoriesTableFilterComposer,
      $$SkillCategoriesTableOrderingComposer,
      $$SkillCategoriesTableAnnotationComposer,
      $$SkillCategoriesTableCreateCompanionBuilder,
      $$SkillCategoriesTableUpdateCompanionBuilder,
      (SkillCategoryRow, $$SkillCategoriesTableReferences),
      SkillCategoryRow,
      PrefetchHooks Function({bool skillsRefs})
    >;
typedef $$SkillsTableCreateCompanionBuilder =
    SkillsCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<String?> nameEn,
      Value<String?> elementId,
      Value<String?> categoryId,
      Value<int?> power,
      Value<int?> accuracy,
      Value<int?> spCost,
      Value<String?> targetJa,
      Value<String?> targetZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });
typedef $$SkillsTableUpdateCompanionBuilder =
    SkillsCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<String?> nameEn,
      Value<String?> elementId,
      Value<String?> categoryId,
      Value<int?> power,
      Value<int?> accuracy,
      Value<int?> spCost,
      Value<String?> targetJa,
      Value<String?> targetZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });

final class $$SkillsTableReferences
    extends BaseReferences<_$AppDatabase, $SkillsTable, SkillRow> {
  $$SkillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElementsTable _elementIdTable(_$AppDatabase db) => db.elements
      .createAlias($_aliasNameGenerator(db.skills.elementId, db.elements.id));

  $$ElementsTableProcessedTableManager? get elementId {
    final $_column = $_itemColumn<String>('element_id');
    if ($_column == null) return null;
    final manager = $$ElementsTableTableManager(
      $_db,
      $_db.elements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_elementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SkillCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.skillCategories.createAlias(
        $_aliasNameGenerator(db.skills.categoryId, db.skillCategories.id),
      );

  $$SkillCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$SkillCategoriesTableTableManager(
      $_db,
      $_db.skillCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DigimonSkillsTable, List<DigimonSkillRow>>
  _digimonSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.digimonSkills,
    aliasName: $_aliasNameGenerator(db.skills.id, db.digimonSkills.skillId),
  );

  $$DigimonSkillsTableProcessedTableManager get digimonSkillsRefs {
    final manager = $$DigimonSkillsTableTableManager(
      $_db,
      $_db.digimonSkills,
    ).filter((f) => f.skillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_digimonSkillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkillsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spCost => $composableBuilder(
    column: $table.spCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetJa => $composableBuilder(
    column: $table.targetJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetZh => $composableBuilder(
    column: $table.targetZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnFilters(column),
  );

  $$ElementsTableFilterComposer get elementId {
    final $$ElementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elementId,
      referencedTable: $db.elements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElementsTableFilterComposer(
            $db: $db,
            $table: $db.elements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillCategoriesTableFilterComposer get categoryId {
    final $$SkillCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.skillCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.skillCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> digimonSkillsRefs(
    Expression<bool> Function($$DigimonSkillsTableFilterComposer f) f,
  ) {
    final $$DigimonSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimonSkills,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonSkillsTableFilterComposer(
            $db: $db,
            $table: $db.digimonSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get power => $composableBuilder(
    column: $table.power,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spCost => $composableBuilder(
    column: $table.spCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetJa => $composableBuilder(
    column: $table.targetJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetZh => $composableBuilder(
    column: $table.targetZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnOrderings(column),
  );

  $$ElementsTableOrderingComposer get elementId {
    final $$ElementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elementId,
      referencedTable: $db.elements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElementsTableOrderingComposer(
            $db: $db,
            $table: $db.elements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillCategoriesTableOrderingComposer get categoryId {
    final $$SkillCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.skillCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.skillCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillsTable> {
  $$SkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<int> get power =>
      $composableBuilder(column: $table.power, builder: (column) => column);

  GeneratedColumn<int> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<int> get spCost =>
      $composableBuilder(column: $table.spCost, builder: (column) => column);

  GeneratedColumn<String> get targetJa =>
      $composableBuilder(column: $table.targetJa, builder: (column) => column);

  GeneratedColumn<String> get targetZh =>
      $composableBuilder(column: $table.targetZh, builder: (column) => column);

  GeneratedColumn<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => column,
  );

  $$ElementsTableAnnotationComposer get elementId {
    final $$ElementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.elementId,
      referencedTable: $db.elements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElementsTableAnnotationComposer(
            $db: $db,
            $table: $db.elements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillCategoriesTableAnnotationComposer get categoryId {
    final $$SkillCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.skillCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.skillCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> digimonSkillsRefs<T extends Object>(
    Expression<T> Function($$DigimonSkillsTableAnnotationComposer a) f,
  ) {
    final $$DigimonSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.digimonSkills,
      getReferencedColumn: (t) => t.skillId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimonSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillsTable,
          SkillRow,
          $$SkillsTableFilterComposer,
          $$SkillsTableOrderingComposer,
          $$SkillsTableAnnotationComposer,
          $$SkillsTableCreateCompanionBuilder,
          $$SkillsTableUpdateCompanionBuilder,
          (SkillRow, $$SkillsTableReferences),
          SkillRow,
          PrefetchHooks Function({
            bool elementId,
            bool categoryId,
            bool digimonSkillsRefs,
          })
        > {
  $$SkillsTableTableManager(_$AppDatabase db, $SkillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> elementId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> spCost = const Value.absent(),
                Value<String?> targetJa = const Value.absent(),
                Value<String?> targetZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillsCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                nameEn: nameEn,
                elementId: elementId,
                categoryId: categoryId,
                power: power,
                accuracy: accuracy,
                spCost: spCost,
                targetJa: targetJa,
                targetZh: targetZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> elementId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int?> power = const Value.absent(),
                Value<int?> accuracy = const Value.absent(),
                Value<int?> spCost = const Value.absent(),
                Value<String?> targetJa = const Value.absent(),
                Value<String?> targetZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillsCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                nameEn: nameEn,
                elementId: elementId,
                categoryId: categoryId,
                power: power,
                accuracy: accuracy,
                spCost: spCost,
                targetJa: targetJa,
                targetZh: targetZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SkillsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                elementId = false,
                categoryId = false,
                digimonSkillsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (digimonSkillsRefs) db.digimonSkills,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (elementId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.elementId,
                                    referencedTable: $$SkillsTableReferences
                                        ._elementIdTable(db),
                                    referencedColumn: $$SkillsTableReferences
                                        ._elementIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$SkillsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$SkillsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (digimonSkillsRefs)
                        await $_getPrefetchedData<
                          SkillRow,
                          $SkillsTable,
                          DigimonSkillRow
                        >(
                          currentTable: table,
                          referencedTable: $$SkillsTableReferences
                              ._digimonSkillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SkillsTableReferences(
                                db,
                                table,
                                p0,
                              ).digimonSkillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.skillId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillsTable,
      SkillRow,
      $$SkillsTableFilterComposer,
      $$SkillsTableOrderingComposer,
      $$SkillsTableAnnotationComposer,
      $$SkillsTableCreateCompanionBuilder,
      $$SkillsTableUpdateCompanionBuilder,
      (SkillRow, $$SkillsTableReferences),
      SkillRow,
      PrefetchHooks Function({
        bool elementId,
        bool categoryId,
        bool digimonSkillsRefs,
      })
    >;
typedef $$DigimonSkillsTableCreateCompanionBuilder =
    DigimonSkillsCompanion Function({
      Value<int> id,
      required String digimonId,
      required String skillId,
      Value<String> acquisition,
      Value<int?> learnLevel,
      Value<String?> noteJa,
      Value<String?> noteZh,
    });
typedef $$DigimonSkillsTableUpdateCompanionBuilder =
    DigimonSkillsCompanion Function({
      Value<int> id,
      Value<String> digimonId,
      Value<String> skillId,
      Value<String> acquisition,
      Value<int?> learnLevel,
      Value<String?> noteJa,
      Value<String?> noteZh,
    });

final class $$DigimonSkillsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DigimonSkillsTable, DigimonSkillRow> {
  $$DigimonSkillsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DigimonsTable _digimonIdTable(_$AppDatabase db) =>
      db.digimons.createAlias(
        $_aliasNameGenerator(db.digimonSkills.digimonId, db.digimons.id),
      );

  $$DigimonsTableProcessedTableManager get digimonId {
    final $_column = $_itemColumn<String>('digimon_id')!;

    final manager = $$DigimonsTableTableManager(
      $_db,
      $_db.digimons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_digimonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SkillsTable _skillIdTable(_$AppDatabase db) => db.skills.createAlias(
    $_aliasNameGenerator(db.digimonSkills.skillId, db.skills.id),
  );

  $$SkillsTableProcessedTableManager get skillId {
    final $_column = $_itemColumn<String>('skill_id')!;

    final manager = $$SkillsTableTableManager(
      $_db,
      $_db.skills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DigimonSkillsTableFilterComposer
    extends Composer<_$AppDatabase, $DigimonSkillsTable> {
  $$DigimonSkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get acquisition => $composableBuilder(
    column: $table.acquisition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get learnLevel => $composableBuilder(
    column: $table.learnLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteJa => $composableBuilder(
    column: $table.noteJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteZh => $composableBuilder(
    column: $table.noteZh,
    builder: (column) => ColumnFilters(column),
  );

  $$DigimonsTableFilterComposer get digimonId {
    final $$DigimonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.digimonId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableFilterComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableFilterComposer get skillId {
    final $$SkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableFilterComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DigimonSkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $DigimonSkillsTable> {
  $$DigimonSkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get acquisition => $composableBuilder(
    column: $table.acquisition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get learnLevel => $composableBuilder(
    column: $table.learnLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteJa => $composableBuilder(
    column: $table.noteJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteZh => $composableBuilder(
    column: $table.noteZh,
    builder: (column) => ColumnOrderings(column),
  );

  $$DigimonsTableOrderingComposer get digimonId {
    final $$DigimonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.digimonId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableOrderingComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableOrderingComposer get skillId {
    final $$SkillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableOrderingComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DigimonSkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DigimonSkillsTable> {
  $$DigimonSkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get acquisition => $composableBuilder(
    column: $table.acquisition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get learnLevel => $composableBuilder(
    column: $table.learnLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get noteJa =>
      $composableBuilder(column: $table.noteJa, builder: (column) => column);

  GeneratedColumn<String> get noteZh =>
      $composableBuilder(column: $table.noteZh, builder: (column) => column);

  $$DigimonsTableAnnotationComposer get digimonId {
    final $$DigimonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.digimonId,
      referencedTable: $db.digimons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DigimonsTableAnnotationComposer(
            $db: $db,
            $table: $db.digimons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillsTableAnnotationComposer get skillId {
    final $$SkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillId,
      referencedTable: $db.skills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.skills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DigimonSkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DigimonSkillsTable,
          DigimonSkillRow,
          $$DigimonSkillsTableFilterComposer,
          $$DigimonSkillsTableOrderingComposer,
          $$DigimonSkillsTableAnnotationComposer,
          $$DigimonSkillsTableCreateCompanionBuilder,
          $$DigimonSkillsTableUpdateCompanionBuilder,
          (DigimonSkillRow, $$DigimonSkillsTableReferences),
          DigimonSkillRow,
          PrefetchHooks Function({bool digimonId, bool skillId})
        > {
  $$DigimonSkillsTableTableManager(_$AppDatabase db, $DigimonSkillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DigimonSkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DigimonSkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DigimonSkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> digimonId = const Value.absent(),
                Value<String> skillId = const Value.absent(),
                Value<String> acquisition = const Value.absent(),
                Value<int?> learnLevel = const Value.absent(),
                Value<String?> noteJa = const Value.absent(),
                Value<String?> noteZh = const Value.absent(),
              }) => DigimonSkillsCompanion(
                id: id,
                digimonId: digimonId,
                skillId: skillId,
                acquisition: acquisition,
                learnLevel: learnLevel,
                noteJa: noteJa,
                noteZh: noteZh,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String digimonId,
                required String skillId,
                Value<String> acquisition = const Value.absent(),
                Value<int?> learnLevel = const Value.absent(),
                Value<String?> noteJa = const Value.absent(),
                Value<String?> noteZh = const Value.absent(),
              }) => DigimonSkillsCompanion.insert(
                id: id,
                digimonId: digimonId,
                skillId: skillId,
                acquisition: acquisition,
                learnLevel: learnLevel,
                noteJa: noteJa,
                noteZh: noteZh,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DigimonSkillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({digimonId = false, skillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (digimonId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.digimonId,
                                referencedTable: $$DigimonSkillsTableReferences
                                    ._digimonIdTable(db),
                                referencedColumn: $$DigimonSkillsTableReferences
                                    ._digimonIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (skillId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.skillId,
                                referencedTable: $$DigimonSkillsTableReferences
                                    ._skillIdTable(db),
                                referencedColumn: $$DigimonSkillsTableReferences
                                    ._skillIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DigimonSkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DigimonSkillsTable,
      DigimonSkillRow,
      $$DigimonSkillsTableFilterComposer,
      $$DigimonSkillsTableOrderingComposer,
      $$DigimonSkillsTableAnnotationComposer,
      $$DigimonSkillsTableCreateCompanionBuilder,
      $$DigimonSkillsTableUpdateCompanionBuilder,
      (DigimonSkillRow, $$DigimonSkillsTableReferences),
      DigimonSkillRow,
      PrefetchHooks Function({bool digimonId, bool skillId})
    >;
typedef $$StatsTableCreateCompanionBuilder =
    StatsCompanion Function({
      required String id,
      required String nameJa,
      Value<String?> nameZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });
typedef $$StatsTableUpdateCompanionBuilder =
    StatsCompanion Function({
      Value<String> id,
      Value<String> nameJa,
      Value<String?> nameZh,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });

class $$StatsTableFilterComposer extends Composer<_$AppDatabase, $StatsTable> {
  $$StatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StatsTableOrderingComposer
    extends Composer<_$AppDatabase, $StatsTable> {
  $$StatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatsTable> {
  $$StatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => column,
  );
}

class $$StatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StatsTable,
          StatRow,
          $$StatsTableFilterComposer,
          $$StatsTableOrderingComposer,
          $$StatsTableAnnotationComposer,
          $$StatsTableCreateCompanionBuilder,
          $$StatsTableUpdateCompanionBuilder,
          (StatRow, BaseReferences<_$AppDatabase, $StatsTable, StatRow>),
          StatRow,
          PrefetchHooks Function()
        > {
  $$StatsTableTableManager(_$AppDatabase db, $StatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameJa = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StatsCompanion(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameJa,
                Value<String?> nameZh = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StatsCompanion.insert(
                id: id,
                nameJa: nameJa,
                nameZh: nameZh,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StatsTable,
      StatRow,
      $$StatsTableFilterComposer,
      $$StatsTableOrderingComposer,
      $$StatsTableAnnotationComposer,
      $$StatsTableCreateCompanionBuilder,
      $$StatsTableUpdateCompanionBuilder,
      (StatRow, BaseReferences<_$AppDatabase, $StatsTable, StatRow>),
      StatRow,
      PrefetchHooks Function()
    >;
typedef $$GlossaryTableCreateCompanionBuilder =
    GlossaryCompanion Function({
      required String id,
      required String termJa,
      Value<String?> termZh,
      Value<String?> category,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });
typedef $$GlossaryTableUpdateCompanionBuilder =
    GlossaryCompanion Function({
      Value<String> id,
      Value<String> termJa,
      Value<String?> termZh,
      Value<String?> category,
      Value<String?> descriptionJa,
      Value<String?> descriptionZh,
      Value<int> rowid,
    });

class $$GlossaryTableFilterComposer
    extends Composer<_$AppDatabase, $GlossaryTable> {
  $$GlossaryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termJa => $composableBuilder(
    column: $table.termJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termZh => $composableBuilder(
    column: $table.termZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GlossaryTableOrderingComposer
    extends Composer<_$AppDatabase, $GlossaryTable> {
  $$GlossaryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termJa => $composableBuilder(
    column: $table.termJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termZh => $composableBuilder(
    column: $table.termZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GlossaryTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlossaryTable> {
  $$GlossaryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get termJa =>
      $composableBuilder(column: $table.termJa, builder: (column) => column);

  GeneratedColumn<String> get termZh =>
      $composableBuilder(column: $table.termZh, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
    builder: (column) => column,
  );
}

class $$GlossaryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GlossaryTable,
          GlossaryRow,
          $$GlossaryTableFilterComposer,
          $$GlossaryTableOrderingComposer,
          $$GlossaryTableAnnotationComposer,
          $$GlossaryTableCreateCompanionBuilder,
          $$GlossaryTableUpdateCompanionBuilder,
          (
            GlossaryRow,
            BaseReferences<_$AppDatabase, $GlossaryTable, GlossaryRow>,
          ),
          GlossaryRow,
          PrefetchHooks Function()
        > {
  $$GlossaryTableTableManager(_$AppDatabase db, $GlossaryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlossaryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlossaryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlossaryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> termJa = const Value.absent(),
                Value<String?> termZh = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GlossaryCompanion(
                id: id,
                termJa: termJa,
                termZh: termZh,
                category: category,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String termJa,
                Value<String?> termZh = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GlossaryCompanion.insert(
                id: id,
                termJa: termJa,
                termZh: termZh,
                category: category,
                descriptionJa: descriptionJa,
                descriptionZh: descriptionZh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GlossaryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GlossaryTable,
      GlossaryRow,
      $$GlossaryTableFilterComposer,
      $$GlossaryTableOrderingComposer,
      $$GlossaryTableAnnotationComposer,
      $$GlossaryTableCreateCompanionBuilder,
      $$GlossaryTableUpdateCompanionBuilder,
      (GlossaryRow, BaseReferences<_$AppDatabase, $GlossaryTable, GlossaryRow>),
      GlossaryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StagesTableTableManager get stages =>
      $$StagesTableTableManager(_db, _db.stages);
  $$AttributesTableTableManager get attributes =>
      $$AttributesTableTableManager(_db, _db.attributes);
  $$TypesTableTableManager get types =>
      $$TypesTableTableManager(_db, _db.types);
  $$ElementsTableTableManager get elements =>
      $$ElementsTableTableManager(_db, _db.elements);
  $$PersonalitiesTableTableManager get personalities =>
      $$PersonalitiesTableTableManager(_db, _db.personalities);
  $$DigimonsTableTableManager get digimons =>
      $$DigimonsTableTableManager(_db, _db.digimons);
  $$EvolutionsTableTableManager get evolutions =>
      $$EvolutionsTableTableManager(_db, _db.evolutions);
  $$EvolutionConditionsTableTableManager get evolutionConditions =>
      $$EvolutionConditionsTableTableManager(_db, _db.evolutionConditions);
  $$SkillCategoriesTableTableManager get skillCategories =>
      $$SkillCategoriesTableTableManager(_db, _db.skillCategories);
  $$SkillsTableTableManager get skills =>
      $$SkillsTableTableManager(_db, _db.skills);
  $$DigimonSkillsTableTableManager get digimonSkills =>
      $$DigimonSkillsTableTableManager(_db, _db.digimonSkills);
  $$StatsTableTableManager get stats =>
      $$StatsTableTableManager(_db, _db.stats);
  $$GlossaryTableTableManager get glossary =>
      $$GlossaryTableTableManager(_db, _db.glossary);
}
