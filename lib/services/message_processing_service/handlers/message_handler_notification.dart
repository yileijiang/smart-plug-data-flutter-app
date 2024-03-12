import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/services/message_processing_service/handlers/message_handler.dart';
import 'package:smart_plug_data/services/notification_service.dart';

class MessageHandlerNotification extends MessageHandler {
  @override
  Future<void> handle(Map<String, dynamic> message, RegisteredSmartPlug? registeredSmartPlug) async {
    bool pushNotificationsSetting = await GetIt.instance<SettingsRepository>().getPushNotificationsSetting();
    bool? getNotificationsThisEntity = registeredSmartPlug?.getNotifications;

    if (pushNotificationsSetting && getNotificationsThisEntity!) {
      GetIt.instance<NotificationService>().showNotification('Smart Plug Activity', 'for ${registeredSmartPlug?.homeAssistantEntityId}', null);
    }

    next?.handle(message, registeredSmartPlug);
  }
}
