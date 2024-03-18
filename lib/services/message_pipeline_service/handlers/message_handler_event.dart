import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';

class MessageHandlerEvent extends MessageHandler {
  @override
  void handle(Map<String, dynamic> message) {
    if (message['type'] != 'event' ||
        message['event']['event_type'] != 'state_changed') {
      return;
    } else {
      next?.handle(message);
    }
  }
}
