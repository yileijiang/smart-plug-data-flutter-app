import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:smart_plug_data/foreground_task/foreground_task_handler.dart';

class ForegroundTaskService {

  ReceivePort? _receivePort;

   void initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
        buttons: [
          const NotificationButton(id: 'sendButton', text: 'Send'),
          const NotificationButton(id: 'testButton', text: 'Test'),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        isOnceEvent: true,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

   Future<void> startForegroundTask() async {
     await FlutterForegroundTask.startService(
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      callback: startCallback,
    );

     _registerReceivePort();
  }

   Future<void> stopForegroundTask() async {
      await FlutterForegroundTask.stopService();
      _closeReceivePort();
  }

  ReceivePort? getReceivePort() {
    return _receivePort;
  }

  _registerReceivePort() {
    _receivePort = FlutterForegroundTask.receivePort;
  }

  _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }





}