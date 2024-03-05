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

  Future deleteRegisteredSmartPlug(
      RegisteredSmartPlug registeredSmartPlug) async {
    return GetIt.instance<DatabaseManager>()
        .database
        .delete(GetIt.instance<DatabaseManager>().database.registeredSmartPlugs)
      ..where((smartPlug) =>
          smartPlug.smartPlugId.equals(registeredSmartPlug.smartPlugId))
      ..go();
  }
}
