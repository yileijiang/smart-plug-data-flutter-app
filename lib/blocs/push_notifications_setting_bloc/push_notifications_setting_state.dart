abstract class PushNotificationsSettingState {}

class PushNotificationsSettingLoading extends PushNotificationsSettingState {
}

class PushNotificationsSettingLoaded extends PushNotificationsSettingState {
  bool pushNotificationsBool;

  PushNotificationsSettingLoaded(this.pushNotificationsBool);
}
