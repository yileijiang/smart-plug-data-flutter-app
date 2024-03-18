abstract class NotificationsSettingEvent {}

class LoadNotificationsSetting extends NotificationsSettingEvent {}

class ToggleNotificationsSwitch extends NotificationsSettingEvent {
  bool notificationsBool;

  ToggleNotificationsSwitch(this.notificationsBool);
}
