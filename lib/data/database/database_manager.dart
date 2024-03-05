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

  Future<void> openDatabaseIsolate() async {
    final isolate = await _createIsolateWithSpawn();
    database = EncryptedDatabase(await isolate.connect(singleClientMode: false));

    IsolateNameServer.registerPortWithName(
      isolate.connectPort, isolateConnectPortName
    );
  }

  Future<void> connectToDatabaseIsolate() async {
    SendPort? isolateConnectPort = IsolateNameServer.lookupPortByName(isolateConnectPortName);

    if (isolateConnectPort != null) {
      final isolate = DriftIsolate.fromConnectPort(isolateConnectPort);

      database =
          EncryptedDatabase(await isolate.connect(singleClientMode: false));
    }
  }

  Future<void> closeDatabase() async {
    await database.close();
  }

  Future<DriftIsolate> _createIsolateWithSpawn() async {
    final token = RootIsolateToken.instance;
    return await DriftIsolate.spawn(() {
      BackgroundIsolateBinaryMessenger.ensureInitialized(token!);

      return _initializeLazyDatabase();
    });
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
