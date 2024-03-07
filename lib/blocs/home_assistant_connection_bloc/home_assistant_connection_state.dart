abstract class HomeAssistantConnectionState {}

class ConnectionEstablished extends HomeAssistantConnectionState {

}

class Connecting extends HomeAssistantConnectionState {
}

class NoConnection extends HomeAssistantConnectionState {
}
