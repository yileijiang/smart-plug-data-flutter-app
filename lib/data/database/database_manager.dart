import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:encrypted_drift/encrypted_drift.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/utils/constants.dart';



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
          path: file.path, password: '123'); // TODO: change password location to encrypted shared preferences
    });
  }



}
