import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler.dart';

class MessageHandlerDeviceClassAttribute extends MessageHandler {
  @override
  void handle(Map<String, dynamic> message, RegisteredSmartPlug? registeredSmartPlug) {
    String? deviceClassAttribute = registeredSmartPlug?.deviceClassAttribute;

    if (!message['event']['data']['new_state']['attributes']
        .containsKey(deviceClassAttribute)) {
      // TODO: show Notification
      return;
    } else {
      next?.handle(message, registeredSmartPlug);
    }
  }
}
