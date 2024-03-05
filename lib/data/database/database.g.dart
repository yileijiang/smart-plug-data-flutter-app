// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SmartPlugEntriesTable extends SmartPlugEntries
    with TableInfo<$SmartPlugEntriesTable, SmartPlugEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartPlugEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
      'entry_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _homeAssistantEntityIdMeta =
      const VerificationMeta('homeAssistantEntityId');
  @override
  late final GeneratedColumn<String> homeAssistantEntityId =
      GeneratedColumn<String>('home_assistant_entity_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime> timeStamp = GeneratedColumn<DateTime>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<double> state = GeneratedColumn<double>(
      'state', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _deviceClassMeta =
      const VerificationMeta('deviceClass');
  @override
  late final GeneratedColumn<String> deviceClass = GeneratedColumn<String>(
      'device_class', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [entryId, homeAssistantEntityId, timeStamp, state, deviceClass, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_plug_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SmartPlugEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    }
    if (data.containsKey('home_assistant_entity_id')) {
      context.handle(
          _homeAssistantEntityIdMeta,
          homeAssistantEntityId.isAcceptableOrUnknown(
              data['home_assistant_entity_id']!, _homeAssistantEntityIdMeta));
    } else if (isInserting) {
      context.missing(_homeAssistantEntityIdMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('device_class')) {
      context.handle(
          _deviceClassMeta,
          deviceClass.isAcceptableOrUnknown(
              data['device_class']!, _deviceClassMeta));
    } else if (isInserting) {
      context.missing(_deviceClassMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId};
  @override
  SmartPlugEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmartPlugEntry(
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entry_id'])!,
      homeAssistantEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}home_assistant_entity_id'])!,
      timeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_stamp'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}state'])!,
      deviceClass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_class'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
    );
  }

  @override
  $SmartPlugEntriesTable createAlias(String alias) {
    return $SmartPlugEntriesTable(attachedDatabase, alias);
  }
}

class SmartPlugEntry extends DataClass implements Insertable<SmartPlugEntry> {
  final int entryId;
  final String homeAssistantEntityId;
  final DateTime timeStamp;
  final double state;
  final String deviceClass;
  final String label;
  const SmartPlugEntry(
      {required this.entryId,
      required this.homeAssistantEntityId,
      required this.timeStamp,
      required this.state,
      required this.deviceClass,
      required this.label});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<int>(entryId);
    map['home_assistant_entity_id'] = Variable<String>(homeAssistantEntityId);
    map['time_stamp'] = Variable<DateTime>(timeStamp);
    map['state'] = Variable<double>(state);
    map['device_class'] = Variable<String>(deviceClass);
    map['label'] = Variable<String>(label);
    return map;
  }

  SmartPlugEntriesCompanion toCompanion(bool nullToAbsent) {
    return SmartPlugEntriesCompanion(
      entryId: Value(entryId),
      homeAssistantEntityId: Value(homeAssistantEntityId),
      timeStamp: Value(timeStamp),
      state: Value(state),
      deviceClass: Value(deviceClass),
      label: Value(label),
    );
  }

  factory SmartPlugEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmartPlugEntry(
      entryId: serializer.fromJson<int>(json['entryId']),
      homeAssistantEntityId:
          serializer.fromJson<String>(json['homeAssistantEntityId']),
      timeStamp: serializer.fromJson<DateTime>(json['timeStamp']),
      state: serializer.fromJson<double>(json['state']),
      deviceClass: serializer.fromJson<String>(json['deviceClass']),
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<int>(entryId),
      'homeAssistantEntityId': serializer.toJson<String>(homeAssistantEntityId),
      'timeStamp': serializer.toJson<DateTime>(timeStamp),
      'state': serializer.toJson<double>(state),
      'deviceClass': serializer.toJson<String>(deviceClass),
      'label': serializer.toJson<String>(label),
    };
  }

  SmartPlugEntry copyWith(
          {int? entryId,
          String? homeAssistantEntityId,
          DateTime? timeStamp,
          double? state,
          String? deviceClass,
          String? label}) =>
      SmartPlugEntry(
        entryId: entryId ?? this.entryId,
        homeAssistantEntityId:
            homeAssistantEntityId ?? this.homeAssistantEntityId,
        timeStamp: timeStamp ?? this.timeStamp,
        state: state ?? this.state,
        deviceClass: deviceClass ?? this.deviceClass,
        label: label ?? this.label,
      );
  @override
  String toString() {
    return (StringBuffer('SmartPlugEntry(')
          ..write('entryId: $entryId, ')
          ..write('homeAssistantEntityId: $homeAssistantEntityId, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('state: $state, ')
          ..write('deviceClass: $deviceClass, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      entryId, homeAssistantEntityId, timeStamp, state, deviceClass, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmartPlugEntry &&
          other.entryId == this.entryId &&
          other.homeAssistantEntityId == this.homeAssistantEntityId &&
          other.timeStamp == this.timeStamp &&
          other.state == this.state &&
          other.deviceClass == this.deviceClass &&
          other.label == this.label);
}

class SmartPlugEntriesCompanion extends UpdateCompanion<SmartPlugEntry> {
  final Value<int> entryId;
  final Value<String> homeAssistantEntityId;
  final Value<DateTime> timeStamp;
  final Value<double> state;
  final Value<String> deviceClass;
  final Value<String> label;
  const SmartPlugEntriesCompanion({
    this.entryId = const Value.absent(),
    this.homeAssistantEntityId = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.state = const Value.absent(),
    this.deviceClass = const Value.absent(),
    this.label = const Value.absent(),
  });
  SmartPlugEntriesCompanion.insert({
    this.entryId = const Value.absent(),
    required String homeAssistantEntityId,
    required DateTime timeStamp,
    required double state,
    required String deviceClass,
    this.label = const Value.absent(),
  })  : homeAssistantEntityId = Value(homeAssistantEntityId),
        timeStamp = Value(timeStamp),
        state = Value(state),
        deviceClass = Value(deviceClass);
  static Insertable<SmartPlugEntry> custom({
    Expression<int>? entryId,
    Expression<String>? homeAssistantEntityId,
    Expression<DateTime>? timeStamp,
    Expression<double>? state,
    Expression<String>? deviceClass,
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (homeAssistantEntityId != null)
        'home_assistant_entity_id': homeAssistantEntityId,
      if (timeStamp != null) 'time_stamp': timeStamp,
      if (state != null) 'state': state,
      if (deviceClass != null) 'device_class': deviceClass,
      if (label != null) 'label': label,
    });
  }

  SmartPlugEntriesCompanion copyWith(
      {Value<int>? entryId,
      Value<String>? homeAssistantEntityId,
      Value<DateTime>? timeStamp,
      Value<double>? state,
      Value<String>? deviceClass,
      Value<String>? label}) {
    return SmartPlugEntriesCompanion(
      entryId: entryId ?? this.entryId,
      homeAssistantEntityId:
          homeAssistantEntityId ?? this.homeAssistantEntityId,
      timeStamp: timeStamp ?? this.timeStamp,
      state: state ?? this.state,
      deviceClass: deviceClass ?? this.deviceClass,
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (homeAssistantEntityId.present) {
      map['home_assistant_entity_id'] =
          Variable<String>(homeAssistantEntityId.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<DateTime>(timeStamp.value);
    }
    if (state.present) {
      map['state'] = Variable<double>(state.value);
    }
    if (deviceClass.present) {
      map['device_class'] = Variable<String>(deviceClass.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartPlugEntriesCompanion(')
          ..write('entryId: $entryId, ')
          ..write('homeAssistantEntityId: $homeAssistantEntityId, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('state: $state, ')
          ..write('deviceClass: $deviceClass, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $RegisteredSmartPlugsTable extends RegisteredSmartPlugs
    with TableInfo<$RegisteredSmartPlugsTable, RegisteredSmartPlug> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegisteredSmartPlugsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _smartPlugIdMeta =
      const VerificationMeta('smartPlugId');
  @override
  late final GeneratedColumn<int> smartPlugId = GeneratedColumn<int>(
      'smart_plug_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _homeAssistantEntityIdMeta =
      const VerificationMeta('homeAssistantEntityId');
  @override
  late final GeneratedColumn<String> homeAssistantEntityId =
      GeneratedColumn<String>('home_assistant_entity_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'UNIQUE');
  static const VerificationMeta _deviceClassAttributeMeta =
      const VerificationMeta('deviceClassAttribute');
  @override
  late final GeneratedColumn<String> deviceClassAttribute =
      GeneratedColumn<String>('device_class_attribute', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _getNotificationsMeta =
      const VerificationMeta('getNotifications');
  @override
  late final GeneratedColumn<bool> getNotifications = GeneratedColumn<bool>(
      'get_notifications', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("get_notifications" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        smartPlugId,
        homeAssistantEntityId,
        deviceClassAttribute,
        getNotifications
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registered_smart_plugs';
  @override
  VerificationContext validateIntegrity(
      Insertable<RegisteredSmartPlug> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('smart_plug_id')) {
      context.handle(
          _smartPlugIdMeta,
          smartPlugId.isAcceptableOrUnknown(
              data['smart_plug_id']!, _smartPlugIdMeta));
    }
    if (data.containsKey('home_assistant_entity_id')) {
      context.handle(
          _homeAssistantEntityIdMeta,
          homeAssistantEntityId.isAcceptableOrUnknown(
              data['home_assistant_entity_id']!, _homeAssistantEntityIdMeta));
    } else if (isInserting) {
      context.missing(_homeAssistantEntityIdMeta);
    }
    if (data.containsKey('device_class_attribute')) {
      context.handle(
          _deviceClassAttributeMeta,
          deviceClassAttribute.isAcceptableOrUnknown(
              data['device_class_attribute']!, _deviceClassAttributeMeta));
    } else if (isInserting) {
      context.missing(_deviceClassAttributeMeta);
    }
    if (data.containsKey('get_notifications')) {
      context.handle(
          _getNotificationsMeta,
          getNotifications.isAcceptableOrUnknown(
              data['get_notifications']!, _getNotificationsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {smartPlugId};
  @override
  RegisteredSmartPlug map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegisteredSmartPlug(
      smartPlugId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}smart_plug_id'])!,
      homeAssistantEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}home_assistant_entity_id'])!,
      deviceClassAttribute: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}device_class_attribute'])!,
      getNotifications: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}get_notifications'])!,
    );
  }

  @override
  $RegisteredSmartPlugsTable createAlias(String alias) {
    return $RegisteredSmartPlugsTable(attachedDatabase, alias);
  }
}

class RegisteredSmartPlug extends DataClass
    implements Insertable<RegisteredSmartPlug> {
  final int smartPlugId;
  final String homeAssistantEntityId;
  final String deviceClassAttribute;
  final bool getNotifications;
  const RegisteredSmartPlug(
      {required this.smartPlugId,
      required this.homeAssistantEntityId,
      required this.deviceClassAttribute,
      required this.getNotifications});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['smart_plug_id'] = Variable<int>(smartPlugId);
    map['home_assistant_entity_id'] = Variable<String>(homeAssistantEntityId);
    map['device_class_attribute'] = Variable<String>(deviceClassAttribute);
    map['get_notifications'] = Variable<bool>(getNotifications);
    return map;
  }

  RegisteredSmartPlugsCompanion toCompanion(bool nullToAbsent) {
    return RegisteredSmartPlugsCompanion(
      smartPlugId: Value(smartPlugId),
      homeAssistantEntityId: Value(homeAssistantEntityId),
      deviceClassAttribute: Value(deviceClassAttribute),
      getNotifications: Value(getNotifications),
    );
  }

  factory RegisteredSmartPlug.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegisteredSmartPlug(
      smartPlugId: serializer.fromJson<int>(json['smartPlugId']),
      homeAssistantEntityId:
          serializer.fromJson<String>(json['homeAssistantEntityId']),
      deviceClassAttribute:
          serializer.fromJson<String>(json['deviceClassAttribute']),
      getNotifications: serializer.fromJson<bool>(json['getNotifications']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'smartPlugId': serializer.toJson<int>(smartPlugId),
      'homeAssistantEntityId': serializer.toJson<String>(homeAssistantEntityId),
      'deviceClassAttribute': serializer.toJson<String>(deviceClassAttribute),
      'getNotifications': serializer.toJson<bool>(getNotifications),
    };
  }

  RegisteredSmartPlug copyWith(
          {int? smartPlugId,
          String? homeAssistantEntityId,
          String? deviceClassAttribute,
          bool? getNotifications}) =>
      RegisteredSmartPlug(
        smartPlugId: smartPlugId ?? this.smartPlugId,
        homeAssistantEntityId:
            homeAssistantEntityId ?? this.homeAssistantEntityId,
        deviceClassAttribute: deviceClassAttribute ?? this.deviceClassAttribute,
        getNotifications: getNotifications ?? this.getNotifications,
      );
  @override
  String toString() {
    return (StringBuffer('RegisteredSmartPlug(')
          ..write('smartPlugId: $smartPlugId, ')
          ..write('homeAssistantEntityId: $homeAssistantEntityId, ')
          ..write('deviceClassAttribute: $deviceClassAttribute, ')
          ..write('getNotifications: $getNotifications')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(smartPlugId, homeAssistantEntityId,
      deviceClassAttribute, getNotifications);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisteredSmartPlug &&
          other.smartPlugId == this.smartPlugId &&
          other.homeAssistantEntityId == this.homeAssistantEntityId &&
          other.deviceClassAttribute == this.deviceClassAttribute &&
          other.getNotifications == this.getNotifications);
}

class RegisteredSmartPlugsCompanion
    extends UpdateCompanion<RegisteredSmartPlug> {
  final Value<int> smartPlugId;
  final Value<String> homeAssistantEntityId;
  final Value<String> deviceClassAttribute;
  final Value<bool> getNotifications;
  const RegisteredSmartPlugsCompanion({
    this.smartPlugId = const Value.absent(),
    this.homeAssistantEntityId = const Value.absent(),
    this.deviceClassAttribute = const Value.absent(),
    this.getNotifications = const Value.absent(),
  });
  RegisteredSmartPlugsCompanion.insert({
    this.smartPlugId = const Value.absent(),
    required String homeAssistantEntityId,
    required String deviceClassAttribute,
    this.getNotifications = const Value.absent(),
  })  : homeAssistantEntityId = Value(homeAssistantEntityId),
        deviceClassAttribute = Value(deviceClassAttribute);
  static Insertable<RegisteredSmartPlug> custom({
    Expression<int>? smartPlugId,
    Expression<String>? homeAssistantEntityId,
    Expression<String>? deviceClassAttribute,
    Expression<bool>? getNotifications,
  }) {
    return RawValuesInsertable({
      if (smartPlugId != null) 'smart_plug_id': smartPlugId,
      if (homeAssistantEntityId != null)
        'home_assistant_entity_id': homeAssistantEntityId,
      if (deviceClassAttribute != null)
        'device_class_attribute': deviceClassAttribute,
      if (getNotifications != null) 'get_notifications': getNotifications,
    });
  }

  RegisteredSmartPlugsCompanion copyWith(
      {Value<int>? smartPlugId,
      Value<String>? homeAssistantEntityId,
      Value<String>? deviceClassAttribute,
      Value<bool>? getNotifications}) {
    return RegisteredSmartPlugsCompanion(
      smartPlugId: smartPlugId ?? this.smartPlugId,
      homeAssistantEntityId:
          homeAssistantEntityId ?? this.homeAssistantEntityId,
      deviceClassAttribute: deviceClassAttribute ?? this.deviceClassAttribute,
      getNotifications: getNotifications ?? this.getNotifications,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (smartPlugId.present) {
      map['smart_plug_id'] = Variable<int>(smartPlugId.value);
    }
    if (homeAssistantEntityId.present) {
      map['home_assistant_entity_id'] =
          Variable<String>(homeAssistantEntityId.value);
    }
    if (deviceClassAttribute.present) {
      map['device_class_attribute'] =
          Variable<String>(deviceClassAttribute.value);
    }
    if (getNotifications.present) {
      map['get_notifications'] = Variable<bool>(getNotifications.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegisteredSmartPlugsCompanion(')
          ..write('smartPlugId: $smartPlugId, ')
          ..write('homeAssistantEntityId: $homeAssistantEntityId, ')
          ..write('deviceClassAttribute: $deviceClassAttribute, ')
          ..write('getNotifications: $getNotifications')
          ..write(')'))
        .toString();
  }
}

abstract class _$EncryptedDatabase extends GeneratedDatabase {
  _$EncryptedDatabase(QueryExecutor e) : super(e);
  late final $SmartPlugEntriesTable smartPlugEntries =
      $SmartPlugEntriesTable(this);
  late final $RegisteredSmartPlugsTable registeredSmartPlugs =
      $RegisteredSmartPlugsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [smartPlugEntries, registeredSmartPlugs];
}
