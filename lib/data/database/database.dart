import 'package:drift/drift.dart';

part 'database.g.dart';

class SmartPlugEntries extends Table {
  IntColumn get entryId => integer().autoIncrement()();
  TextColumn get homeAssistantEntityId =>
      text().named('home_assistant_entity_id')();
  DateTimeColumn get timeStamp => dateTime().named('time_stamp')();
  RealColumn get state => real().named('state')();
  TextColumn get deviceClass => text().named('device_class')();
  TextColumn get label =>
      text().named('label').withDefault(const Constant(''))();
}

class RegisteredSmartPlugs extends Table {
  IntColumn get smartPlugId => integer().autoIncrement()();
  TextColumn get homeAssistantEntityId =>
      text().named('home_assistant_entity_id').unique()();
  TextColumn get deviceClassAttribute =>
      text().named('device_class_attribute')();
  BoolColumn get getNotifications =>
      boolean().named('get_notifications').withDefault(const Constant(false))();
}

class Settings extends Table {
  TextColumn get homeAssistantAddress =>
      text().named('home_assistant_address').withDefault(const Constant(''))();
  TextColumn get accessToken =>
      text().named('access_token').withDefault(const Constant(''))();
  BoolColumn get notificationsSetting => boolean()
      .named('notifications_setting')
      .withDefault(const Constant(false))();
  BoolColumn get connectionStatus =>
      boolean().named('connection_status').withDefault(const Constant(false))();
}

@DriftDatabase(tables: [SmartPlugEntries, RegisteredSmartPlugs, Settings])
class EncryptedDatabase extends _$EncryptedDatabase {
  EncryptedDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
