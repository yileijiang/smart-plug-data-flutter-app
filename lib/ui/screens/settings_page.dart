import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_event.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_event.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/ui/widgets/access_token_widget.dart';
import 'package:smart_plug_data/ui/widgets/home_assistant_address_widget.dart';
import 'package:smart_plug_data/ui/widgets/home_assistant_connection_widget.dart';
import 'package:smart_plug_data/ui/widgets/push_notifications_switch_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SettingsRepository>(
      create: (context) => SettingsRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeAssistantAddressBloc>(
            create: (context) => HomeAssistantAddressBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(LoadHomeAssistantAddress()),
          ),
          BlocProvider<AccessTokenBloc>(
            create: (context) => AccessTokenBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(LoadAccessToken()),
          ),
          BlocProvider<PushNotificationsSettingBloc>(
            create: (context) => PushNotificationsSettingBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(LoadPushNotificationsSetting()),
          ),
          BlocProvider<HomeAssistantConnectionBloc>(
            create: (context) => HomeAssistantConnectionBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(LoadConnectionStatus()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  HomeAssistantAddressWidget(),
                  AccessTokenWidget(),
                  PushNotificationsSwitchWidget(),
                  HomeAssistantConnectionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
