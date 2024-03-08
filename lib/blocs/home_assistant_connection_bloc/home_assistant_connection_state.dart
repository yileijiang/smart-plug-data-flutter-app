abstract class HomeAssistantConnectionState {}

class ConnectionStatusLoading extends HomeAssistantConnectionState {}

class NoConnection extends HomeAssistantConnectionState {}

class Connecting extends HomeAssistantConnectionState {}

class Connected extends HomeAssistantConnectionState {}
