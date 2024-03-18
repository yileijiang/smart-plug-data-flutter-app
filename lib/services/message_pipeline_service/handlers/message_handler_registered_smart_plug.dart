import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';

class MessageHandlerRegisteredSmartPlug extends MessageHandler {
  @override
  Future<void> handle(Map<String, dynamic> message) async {
    String homeAssistantEntityId = message['event']['data']['entity_id'];
    RegisteredSmartPlug? registeredSmartPlug =
        await GetIt.instance<RegisteredSmartPlugsRepository>()
            .getRegisteredSmartPlugByHomeAssistantEntityId(
                homeAssistantEntityId);

    if (registeredSmartPlug == null) {
      return;
    } else {
      MessageHandler.setRegisteredSmartPlug(registeredSmartPlug);
      next?.handle(message);
    }
  }
}
