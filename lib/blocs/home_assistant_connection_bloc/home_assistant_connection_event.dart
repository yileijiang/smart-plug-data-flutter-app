abstract class HomeAssistantConnectionEvent {}

class LoadConnectionStatus extends HomeAssistantConnectionEvent {
}

class EstablishConnectionToHomeAssistantAPI extends HomeAssistantConnectionEvent {
}

class UpdateConnectionStatusToConnected extends HomeAssistantConnectionEvent {
}

class TerminateConnectionToHomeAssistantAPI extends HomeAssistantConnectionEvent {
}
