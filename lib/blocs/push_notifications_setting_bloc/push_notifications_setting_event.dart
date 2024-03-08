abstract class PushNotificationsSettingEvent {}

class LoadPushNotificationsSetting extends PushNotificationsSettingEvent {
}

class TogglePushNotificationsSwitch extends PushNotificationsSettingEvent {
  bool pushNotificationsBool;

  TogglePushNotificationsSwitch(this.pushNotificationsBool);
}
