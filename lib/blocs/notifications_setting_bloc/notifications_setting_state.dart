abstract class NotificationsSettingState {}

class NotificationsSettingLoading extends NotificationsSettingState {}

class NotificationsSettingLoaded extends NotificationsSettingState {
  bool notificationsBool;

  NotificationsSettingLoaded(this.notificationsBool);
}
