import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/shared_preferences/shared_preferences_manager.dart';

class SettingsRepository {
  final sharedPreferencesManager = GetIt.instance<SharedPreferencesManager>();

  Future<bool> getNotificationsSetting() async {
    final notificationsString =
        await sharedPreferencesManager.getString('notifications_setting');
    bool notificationsBool = notificationsString == 'true';
    return notificationsBool;
  }

  Future<void> saveNotificationsSetting(bool notificationsBool) async {
    await sharedPreferencesManager.saveString(
        'notifications_setting', notificationsBool.toString());
  }

  Future<String> getHomeAssistantAddress() async {
    return await sharedPreferencesManager.getString('home_assistant_address');
  }

  Future<void> saveHomeAssistantAddress(String homeAssistantAddress) async {
    if (homeAssistantAddress.isNotEmpty) {
      await sharedPreferencesManager.saveString(
          'home_assistant_address', homeAssistantAddress);
    } else {
      await sharedPreferencesManager.deleteString('home_assistant_address');
    }
  }

  Future<String> getAccessToken() async {
    return await sharedPreferencesManager.getString('access_token');
  }

  Future<void> saveAccessToken(String accessToken) async {
    if (accessToken.isNotEmpty) {
      await sharedPreferencesManager.saveString('access_token', accessToken);
    } else {
      await sharedPreferencesManager.deleteString('access_token');
    }
  }

  Future<bool> getConnectionStatus() async {
    final connectionStatus =
    await sharedPreferencesManager.getString('connection_status');
    bool connectionStatusBool = connectionStatus == 'true';
    return connectionStatusBool;
  }

  Future<void> saveConnectionStatus(bool connectionStatusBool) async {
    await sharedPreferencesManager.saveString(
        'connection_status', connectionStatusBool.toString());
  }
}
