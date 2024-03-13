import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';


class MessageHandlerDeviceClassAttribute extends MessageHandler {
  @override
  void handle(message) {
    String deviceClassAttribute = MessageHandler.registeredSmartPlug.deviceClassAttribute;

    if (!message['event']['data']['new_state']['attributes']
        .containsKey(deviceClassAttribute)) {
      // TODO: show Notification
      return;
    } else {
      next?.handle(message);
    }
  }
}
