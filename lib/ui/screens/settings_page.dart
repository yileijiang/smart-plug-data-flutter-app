import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_bloc.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_event.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/ui/widgets/settings_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SettingsRepository>(
      create: (context) => SettingsRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(LoadSettings()),
          ),
          BlocProvider<PushNotificationsSettingBloc>(
            create: (context) => PushNotificationsSettingBloc(
              settingsRepository: context.read<SettingsRepository>(),
            ),
          ),
          BlocProvider<HomeAssistantAddressBloc>(
            create: (context) => HomeAssistantAddressBloc(
              settingsRepository: context.read<SettingsRepository>(),
            ),
          ),
          BlocProvider<AccessTokenBloc>(
            create: (context) => AccessTokenBloc(
              settingsRepository: context.read<SettingsRepository>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: const Center(
            child: SettingsWidget(),
          ),
        ),
      ),
    );
  }
}
