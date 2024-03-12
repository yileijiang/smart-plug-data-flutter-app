import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler.dart';

class MessageHandlerEvent extends MessageHandler {

  @override
  void handle(Map<String, dynamic> message, RegisteredSmartPlug? registeredSmartPlug) {
    if (message['type'] != 'event' || message['event']['event_type'] != 'state_changed') {
      return;
    } else {
      next?.handle(message, null);
    }
  }
}
