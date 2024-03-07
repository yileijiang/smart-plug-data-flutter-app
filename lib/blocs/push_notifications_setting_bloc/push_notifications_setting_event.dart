abstract class PushNotificationsSettingEvent {}

class TogglePushNotificationsSwitch extends PushNotificationsSettingEvent {
  bool pushNotificationsBool;

  TogglePushNotificationsSwitch(this.pushNotificationsBool);
}
