import 'dart:async';

import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/data/database/database.dart';

class RegisteredSmartPlugsRepository {
  Future<List<RegisteredSmartPlug>> getRegisteredSmartPlugs() async {
    List<RegisteredSmartPlug> registeredSmartPlugs =
        await (GetIt.instance<DatabaseManager>().database.select(
                GetIt.instance<DatabaseManager>()
                    .database
                    .registeredSmartPlugs))
            .get();

    return registeredSmartPlugs;
  }

  Future<RegisteredSmartPlug?> getRegisteredSmartPlugByHomeAssistantEntityId(String homeAssistantEntityId) async {
    RegisteredSmartPlug? registeredSmartPlug =
    await (GetIt.instance<DatabaseManager>().database.select(
        GetIt.instance<DatabaseManager>()
            .database
            .registeredSmartPlugs)..where((smartPlug) =>
        smartPlug.homeAssistantEntityId.equals(homeAssistantEntityId)))
        .getSingleOrNull();

    return registeredSmartPlug;
  }

  Future<void> createRegisteredSmartPlug(String homeAssistantEntityId , String deviceClassAttribute, bool getNotificationsBoolean) async {
    final newSmartPlug = RegisteredSmartPlugsCompanion(
      homeAssistantEntityId: Value(homeAssistantEntityId),
      deviceClassAttribute: Value(deviceClassAttribute),
      getNotifications: Value(getNotificationsBoolean),
    );

    await GetIt.instance<DatabaseManager>().database.into(GetIt.instance<DatabaseManager>().database.registeredSmartPlugs).insert(newSmartPlug);
  }

  Future<void> updateRegisteredSmartPlug(
      RegisteredSmartPlug registeredSmartPlug,
      String homeAssistantEntityId,
      String deviceClassAttribute,
      bool getNotificationsBoolean) async {
    await (GetIt.instance<DatabaseManager>().database.update(
            GetIt.instance<DatabaseManager>().database.registeredSmartPlugs)
          ..where((smartPlug) =>
              smartPlug.smartPlugId.equals(registeredSmartPlug.smartPlugId)))
        .write(RegisteredSmartPlugsCompanion(
            homeAssistantEntityId: Value(homeAssistantEntityId),
            deviceClassAttribute: Value(deviceClassAttribute),
            getNotifications: Value(getNotificationsBoolean)));
  }

  Future<void> deleteRegisteredSmartPlug(
      RegisteredSmartPlug registeredSmartPlug) async {
    await (GetIt.instance<DatabaseManager>()
        .database
        .delete(GetIt.instance<DatabaseManager>().database.registeredSmartPlugs)
      ..where((smartPlug) =>
          smartPlug.smartPlugId.equals(registeredSmartPlug.smartPlugId))).go();
  }
}
