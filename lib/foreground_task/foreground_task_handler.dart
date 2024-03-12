import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/di/dependencies.dart';
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

    await GetIt.instance<DatabaseManager>().openDatabaseIsolate();
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

  // Called when the notification button on the Android platform is pressed.
  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}

  // Called when the notification button on the Android platform is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed >> $id');
  }

  // Called when the notification itself on the Android platform is pressed.
  //
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // this function to be called.
  @override
  void onNotificationPressed() {
    // Note that the app will only route to "/resume-route" when it is exited so
    // it will usually be necessary to send a message through the send port to
    // signal it to restore state when the app is already started.
    FlutterForegroundTask.launchApp("/resume-route");
    // _sendPort?.send('onNotificationPressed');
  }

}
