import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_bloc.dart';
import 'package:smart_plug_data/data/database/database_manager.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/di/dependencies.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';
import 'package:smart_plug_data/services/notification_service.dart';
import 'package:smart_plug_data/ui/screens/home_page.dart';
import 'package:smart_plug_data/ui/style/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Dependencies.setupDependencies();
  GetIt.instance<ForegroundTaskService>().initForegroundTask();
  GetIt.instance<NotificationService>().init();
  GetIt.instance<DatabaseManager>().openDatabase();

  runApp(MultiBlocProvider(providers: [
    RepositoryProvider(
      create: (context) => SettingsRepository(),
    ),
    BlocProvider<HomeAssistantConnectionBloc>(
      create: (context) => HomeAssistantConnectionBloc(
        settingsRepository: context.read<SettingsRepository>(),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData(),
      home: const HomePage(),
    );
  }
}
