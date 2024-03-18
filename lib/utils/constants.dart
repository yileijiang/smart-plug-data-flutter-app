class Constants {
  static const String isolateConnectPortName = "IsolateConnectPort";

  static String webSocketAPIAddress(String homeAssistantAddress) {
    return 'ws://$homeAssistantAddress/api/websocket';
  }

  static String webSocketAuthenticationMessage(String accessToken) {
    return '{"type": "auth", "access_token": "$accessToken"}';
  }

  static String eventsSubscriptionMessage =
      '{"id": 1, "type": "subscribe_events", "event_type": "state_changed"}';
}
