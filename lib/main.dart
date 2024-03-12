import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/di/dependencies.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';
import 'package:smart_plug_data/ui/screens/home_page.dart';

import 'data/database/database.dart';
// access token
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0MzQ3MjFjZjJjNTI0ZDMyOTI1YzNkYTNmYmFkZDg0OCIsImlhdCI6MTcxMDA4OTI3NCwiZXhwIjoyMDI1NDQ5Mjc0fQ.x7es_WKHpfaFGf05R2u2uO6i2LY2sAR8AfiRLOqU3Mw
/*
  await database.into(database.smartPlugEntries).insert(SmartPlugEntriesCompanion.insert(
    homeAssistantEntityId: 'entityId',
    timeStamp: DateTime.now(),
    state: 2.0,
    deviceClass: 'power',
  ));
   */


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Dependencies.setupDependencies();
  GetIt.instance<ForegroundTaskService>().initForegroundTask();


  if (await FlutterForegroundTask.isRunningService) {
    await GetIt.instance<DatabaseManager>().connectToDatabaseIsolate();

    var allEntries = await GetIt.instance<DatabaseManager>().database.select(GetIt.instance<DatabaseManager>().database.smartPlugEntries).get();
    print('items in database from MAIN RUNNING FG TASK: $allEntries');
  } else {
    GetIt.instance<DatabaseManager>().openDatabase();
    //var allEntries = await GetIt.instance<DatabaseManager>().database.select(GetIt.instance<DatabaseManager>().database.registeredSmartPlugs).get();
    //print('items in database from MAIN NO FG TASK: $allEntries');
/*
     await GetIt.instance<DatabaseManager>().database.into(GetIt.instance<DatabaseManager>().database.registeredSmartPlugs).insert(RegisteredSmartPlugsCompanion.insert(
      homeAssistantEntityId: 'Hello Poop Id 200',
      deviceClassAttribute: 'DEVICE CLASS',
      // label: Value('pooping'),
    ));

    await GetIt.instance<DatabaseManager>().database.into(GetIt.instance<DatabaseManager>().database.registeredSmartPlugs).insert(RegisteredSmartPlugsCompanion.insert(
      homeAssistantEntityId: 'Hello Poop Id 300',
      deviceClassAttribute: 'DEVICE CLASS',
      // label: Value('pooping'),
    ));



    await GetIt.instance<DatabaseManager>().database.into(GetIt.instance<DatabaseManager>().database.smartPlugEntries).insert(SmartPlugEntriesCompanion.insert(
      homeAssistantEntityId: 'Home Assistant entity Id 2',
      timeStamp: DateTime.now(),
      state: 3.0,
      deviceClass: 'power',
      label: Value('pooping 2'),
    ));

     */

  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

