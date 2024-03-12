import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler.dart';

class MessageHandlerRegisteredSmartPlug extends MessageHandler {

  @override
  Future<void> handle(Map<String, dynamic> message, RegisteredSmartPlug? registeredSmartPlug) async {
    String homeAssistantEntityId = message['event']['data']['entity_id'];
    RegisteredSmartPlug? registeredSmartPlug = await GetIt.instance<RegisteredSmartPlugsRepository>().getRegisteredSmartPlugByHomeAssistantEntityId(
        homeAssistantEntityId);

    if (registeredSmartPlug == null) {
      return;
    } else {
      next?.handle(message, registeredSmartPlug);
    }
  }
}
