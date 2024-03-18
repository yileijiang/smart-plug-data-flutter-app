import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';
import 'package:smart_plug_data/services/notification_service.dart';

class MessageHandlerNotification extends MessageHandler {
  @override
  Future<void> handle(Map<String, dynamic> message) async {
    bool notificationsSetting =
        await GetIt.instance<SettingsRepository>().getNotificationsSetting();
    bool notificationsThisEntity =
        MessageHandler.registeredSmartPlug.getNotifications;

    if (notificationsSetting && notificationsThisEntity) {
      GetIt.instance<NotificationService>().showNotification(
          'Smart Plug Activity',
          'for ${MessageHandler.registeredSmartPlug.homeAssistantEntityId}',
          MessageHandler.entryId.toString());
    }

    next?.handle(message);
  }
}
