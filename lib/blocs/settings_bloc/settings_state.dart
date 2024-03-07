abstract class SettingsState {}

class SettingsLoading extends SettingsState {
}


class SettingsLoaded extends SettingsState {
  final String homeAssistantAddress;
  final String accessToken;
  final bool pushNotificationsBool;

  SettingsLoaded(this.homeAssistantAddress, this.accessToken, this.pushNotificationsBool);
}

class SettingsError extends SettingsState {
  final String errorMessage;

  SettingsError(this.errorMessage);
}
