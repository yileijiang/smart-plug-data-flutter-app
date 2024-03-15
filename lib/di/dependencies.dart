import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries%20_repository.dart';
import 'package:smart_plug_data/services/encryption_service.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';
import 'package:smart_plug_data/services/home_assistant_websocket_api_service.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler_device_class_attribute.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler_event.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler_new_entry.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler_notification.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler_registered_smart_plug.dart';
import 'package:smart_plug_data/services/message_pipeline_service/message_pipeline_manager.dart';
import 'package:smart_plug_data/services/notification_service.dart';

class Dependencies {

  static void setupDependencies() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository());
    getIt.registerLazySingleton<SmartPlugEntriesRepository>(() => SmartPlugEntriesRepository());
    getIt.registerLazySingleton<RegisteredSmartPlugsRepository>(() => RegisteredSmartPlugsRepository());

    getIt.registerLazySingleton<ForegroundTaskService>(() => ForegroundTaskService());
    getIt.registerLazySingleton<HomeAssistantWebSocketAPIService>(() => HomeAssistantWebSocketAPIService());
    getIt.registerLazySingleton<NotificationService>(() => NotificationService());
    getIt.registerLazySingleton<EncryptionService>(() => EncryptionService());


    getIt.registerLazySingleton<DatabaseManager>(() => DatabaseManager());

    getIt.registerLazySingleton<MessagePipelineManager>(() => MessagePipelineManager());
    getIt.registerLazySingleton<MessageHandlerEvent>(() => MessageHandlerEvent());
    getIt.registerLazySingleton<MessageHandlerRegisteredSmartPlug>(() => MessageHandlerRegisteredSmartPlug());
    getIt.registerLazySingleton<MessageHandlerDeviceClassAttribute>(() => MessageHandlerDeviceClassAttribute());
    getIt.registerLazySingleton<MessageHandlerNewEntry>(() => MessageHandlerNewEntry());
    getIt.registerLazySingleton<MessageHandlerNotification>(() => MessageHandlerNotification());
  }


}

