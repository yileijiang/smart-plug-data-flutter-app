import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/shared_preferences/shared_preferences_manager.dart';

class SettingsRepository {
  final sharedPreferencesManager = GetIt.instance<SharedPreferencesManager>();

  Future<bool> getPushNotificationsSetting() async {
    final pushNotificationsString =
        await sharedPreferencesManager.getString('push_notifications_setting');
    bool pushNotificationsBool = pushNotificationsString == 'true';
    return pushNotificationsBool;
  }

  Future<void> savePushNotificationsSetting(bool pushNotificationsBool) async {
    await sharedPreferencesManager.saveString(
        'push_notifications_setting', pushNotificationsBool.toString());
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
}
