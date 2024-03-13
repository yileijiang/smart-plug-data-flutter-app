import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/di/dependencies.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';
import 'package:smart_plug_data/services/home_assistant_websocket_api_service.dart';
import 'package:smart_plug_data/services/notification_service.dart';


@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}

class ForegroundTaskHandler extends TaskHandler {

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {

    Dependencies.setupDependencies();

    GetIt.instance<DatabaseManager>().openDatabase();

    GetIt.instance<NotificationService>().init();

    GetIt.instance<HomeAssistantWebSocketAPIService>().setSendPort(sendPort!);
    await GetIt.instance<HomeAssistantWebSocketAPIService>().establishAPIConnection();
    await GetIt.instance<HomeAssistantWebSocketAPIService>().listenToChannelMessages();
    await GetIt.instance<HomeAssistantWebSocketAPIService>().authenticateWithAccessToken();
    GetIt.instance<HomeAssistantWebSocketAPIService>().subscribeToEvents();
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}

  @override
  Future<void> onNotificationButtonPressed(String id) async {
    await GetIt.instance<SettingsRepository>().saveConnectionStatus(false);
    GetIt.instance<ForegroundTaskService>().stopForegroundTask();
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp("/resume-route");
  }

}
