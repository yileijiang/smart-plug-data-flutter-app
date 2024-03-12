import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler_device_class_attribute.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler_event.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler_new_entry.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler_notification.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler_registered_smart_plug.dart';

class MessageHandlerManager {
  MessageHandler messageHandlerEvent = GetIt.instance<MessageHandlerEvent>();
  MessageHandler messageHandlerRegisteredSmartPlug = GetIt.instance<MessageHandlerRegisteredSmartPlug>();
  MessageHandler messageHandlerDeviceClassAttribute = GetIt.instance<MessageHandlerDeviceClassAttribute>();
  MessageHandler messageHandlerNewEntry = GetIt.instance<MessageHandlerNewEntry>();
  MessageHandler messageHandlerNotification = GetIt.instance<MessageHandlerNotification>();

  MessageHandler setUpHandlerChain() {
    messageHandlerEvent.setNext(messageHandlerRegisteredSmartPlug);
    messageHandlerRegisteredSmartPlug.setNext(messageHandlerDeviceClassAttribute);
    messageHandlerDeviceClassAttribute.setNext(messageHandlerNewEntry);
    messageHandlerNewEntry.setNext(messageHandlerNotification);

    return messageHandlerEvent;
  }
}