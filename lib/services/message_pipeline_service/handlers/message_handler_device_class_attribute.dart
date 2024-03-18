import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';
import 'package:smart_plug_data/services/notification_service.dart';

class MessageHandlerDeviceClassAttribute extends MessageHandler {
  @override
  void handle(message) {
    String deviceClassAttribute =
        MessageHandler.registeredSmartPlug.deviceClassAttribute;

    if (!message['event']['data']['new_state']['attributes']
        .containsKey(deviceClassAttribute)) {
      GetIt.instance<NotificationService>().showNotification(
          'Error with Smart Plug',
          'The device class attribute \'$deviceClassAttribute\' does not exist for ${MessageHandler.registeredSmartPlug.homeAssistantEntityId}',
          null);

      return;
    } else {
      next?.handle(message);
    }
  }
}
