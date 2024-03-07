import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/data/shared_preferences/shared_preferences_manager.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';

class Dependencies {

  static void setupDependencies() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<ForegroundTaskService>(() => ForegroundTaskService());
    getIt.registerLazySingleton<DatabaseManager>(() => DatabaseManager());
    getIt.registerLazySingleton<SharedPreferencesManager>(() => SharedPreferencesManager());

  }

}

