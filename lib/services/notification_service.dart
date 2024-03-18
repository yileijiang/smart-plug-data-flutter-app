import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final notificationController = StreamController<String?>();
  Stream<String?> get notificationStream => notificationController.stream;

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('home_assistant_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);

    _launchDialogWhenAppOpenedFromNotification();
  }

  Future<void> showNotification(
      String title, String body, String? payload) async {
    Random random = Random();
    int id = random.nextInt(2147483647);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'smart_plug_notification',
      'Smart Plug Notification',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    notificationController.add(notificationResponse.payload);
  }

  void _launchDialogWhenAppOpenedFromNotification() async {
    var notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails!.didNotificationLaunchApp) {
      final notificationResponse =
          notificationAppLaunchDetails.notificationResponse;
      notificationController.add(notificationResponse?.payload);
    }
  }
}
