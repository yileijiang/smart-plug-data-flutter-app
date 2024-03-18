import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/shared_preferences_manager.dart';

class PasswordRepository {
  final sharedPreferencesManager = GetIt.instance<SharedPreferencesManager>();

  Future<String> getPassword() async {
    return await sharedPreferencesManager
        .getString('drift_encryption_password');
  }

  Future<void> savePassword(String encryptionPassword) async {
    await sharedPreferencesManager.saveString(
        'drift_encryption_password', encryptionPassword);
  }
}
