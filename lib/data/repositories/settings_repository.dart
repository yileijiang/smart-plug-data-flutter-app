import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';

class SettingsRepository {
  final _database = GetIt.instance<DatabaseManager>().database;

  SettingsRepository() {
    _insertSettingsRowIfNone();
  }

  Future<bool> getNotificationsSetting() async {
    bool? notificationsBool = (await (_database.selectOnly(_database.settings)
              ..addColumns([_database.settings.notificationsSetting])
              ..limit(1))
            .getSingleOrNull())
        ?.read(_database.settings.notificationsSetting);

    return notificationsBool ?? false;
  }

  Future<void> saveNotificationsSetting(bool notificationsBool) async {
    await _database.update(_database.settings).write(SettingsCompanion(notificationsSetting: Value(notificationsBool)));

  }

  Future<String> getHomeAssistantAddress() async {
    String? homeAssistantAddress =
        (await (_database.selectOnly(_database.settings)
                  ..addColumns([_database.settings.homeAssistantAddress])
                  ..limit(1))
                .getSingleOrNull())
            ?.read(_database.settings.homeAssistantAddress);

    return homeAssistantAddress ?? '';
  }

  Future<void> saveHomeAssistantAddress(String homeAssistantAddress) async {
    await _database.update(_database.settings).write(SettingsCompanion(homeAssistantAddress: Value(homeAssistantAddress)));
  }

  Future<String> getAccessToken() async {
    String? accessToken = (await (_database.selectOnly(_database.settings)
              ..addColumns([_database.settings.accessToken])
              ..limit(1))
            .getSingleOrNull())
        ?.read(_database.settings.accessToken);

    return accessToken ?? '';
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _database.update(_database.settings).write(SettingsCompanion(accessToken: Value(accessToken)));
  }

  Future<bool> getConnectionStatus() async {
    bool? connectionStatus = (await (_database.selectOnly(_database.settings)
      ..addColumns([_database.settings.connectionStatus])
      ..limit(1))
        .getSingleOrNull())
        ?.read(_database.settings.connectionStatus);

    return connectionStatus ?? false;
  }

  Future<void> saveConnectionStatus(bool connectionStatusBool) async {
    await _database.update(_database.settings).write(SettingsCompanion(connectionStatus: Value(connectionStatusBool)));
  }

  Future<void> _insertSettingsRowIfNone() async {
    if (await _database.settings.count().getSingle() == 0) {
      const settingsRow = SettingsCompanion(
      );
      await _database.into(_database.settings).insert(settingsRow);
    }
  }
}
