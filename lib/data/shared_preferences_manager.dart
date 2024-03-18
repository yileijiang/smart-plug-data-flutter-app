import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class SharedPreferencesManager {
  final EncryptedSharedPreferences _sharedPreferences =
      EncryptedSharedPreferences();

  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<String> getString(String key) async {
    return _sharedPreferences.getString(key);
  }
}
