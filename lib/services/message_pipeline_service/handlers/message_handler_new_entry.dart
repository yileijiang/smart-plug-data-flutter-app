import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries%20_repository.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';

class MessageHandlerNewEntry extends MessageHandler {
  @override
  Future<void> handle(Map<String, dynamic> message) async {
    String deviceClassAttribute =
        MessageHandler.registeredSmartPlug.deviceClassAttribute;

    String homeAssistantEntityId = message['event']['data']['entity_id'];
    String timeStampString = message['event']['time_fired'];
    DateTime timeStamp = DateTime.parse(timeStampString);
    double state = double.parse(message['event']['data']['new_state']['state']);
    String deviceClass = message['event']['data']['new_state']['attributes']
        [deviceClassAttribute];

    int entryId = await GetIt.instance<SmartPlugEntriesRepository>()
        .createSmartPlugEntry(
            homeAssistantEntityId, timeStamp, state, deviceClass);
    MessageHandler.setEntryId(entryId);

    next?.handle(message);
  }
}
