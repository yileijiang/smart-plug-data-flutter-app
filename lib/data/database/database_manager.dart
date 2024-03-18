import 'dart:io';

import 'package:drift/drift.dart';
import 'package:encrypted_drift/encrypted_drift.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/repositories/password_repository.dart';
import 'package:uuid/uuid.dart';

class DatabaseManager {
  late EncryptedDatabase database;

  void openDatabase() {
    database = EncryptedDatabase(_initializeLazyDatabase());
  }

  LazyDatabase _initializeLazyDatabase() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      return EncryptedExecutor.inDatabaseFolder(
          path: file.path, password: await _getOrGeneratePassword());
    });
  }

  Future<String> _getOrGeneratePassword() async {
    String password = await GetIt.instance<PasswordRepository>().getPassword();
    if (password.isEmpty) {
      var uuid = const Uuid();
      String newPassword = uuid.v4();
      await GetIt.instance<PasswordRepository>().savePassword(newPassword);
      return newPassword;
    } else {
      return password;
    }
  }
}
