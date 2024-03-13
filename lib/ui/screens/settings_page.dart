import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_event.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_state.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_state.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_state.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_state.dart';
import 'package:smart_plug_data/blocs/settings_page_bloc/settings_page_bloc.dart';
import 'package:smart_plug_data/blocs/settings_page_bloc/settings_page_event.dart';
import 'package:smart_plug_data/blocs/settings_page_bloc/settings_page_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/ui/widgets/access_token_widget.dart';
import 'package:smart_plug_data/ui/widgets/home_assistant_address_widget.dart';
import 'package:smart_plug_data/ui/widgets/home_assistant_connection_widget.dart';
import 'package:smart_plug_data/ui/widgets/notifications_switch_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<HomeAssistantConnectionBloc>(context)
        .add(LoadConnectionStatus());

    return RepositoryProvider<SettingsRepository>(
      create: (context) => SettingsRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsPageBloc>(
            create: (context) => SettingsPageBloc(),
          ),
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
          BlocProvider<NotificationsSettingBloc>(
            create: (context) => NotificationsSettingBloc(
              settingsRepository: context.read<SettingsRepository>(),
            )..add(LoadNotificationsSetting()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<HomeAssistantAddressBloc, HomeAssistantAddressState>(
                  listener: (context, state) {
                if (state is HomeAssistantAddressLoaded) {
                  BlocProvider.of<SettingsPageBloc>(context)
                      .add(HomeAssistantAddressWidgetLoaded());
                }
              }),
              BlocListener<AccessTokenBloc, AccessTokenState>(
                listener: (context, state) {
                  if (state is AccessTokenLoaded) {
                    BlocProvider.of<SettingsPageBloc>(context)
                        .add(AccessTokenWidgetLoaded());
                  }
                },
              ),
              BlocListener<NotificationsSettingBloc,
                  NotificationsSettingState>(
                listener: (context, state) {
                  if (state is NotificationsSettingLoaded) {
                    BlocProvider.of<SettingsPageBloc>(context)
                        .add(PushNotificationsSettingWidgetLoaded());
                  }
                },
              ),
              BlocListener<HomeAssistantConnectionBloc,
                  HomeAssistantConnectionState>(
                listener: (context, state) {
                  if (state is NoConnection ||
                      state is Connecting ||
                      state is Connected) {
                    BlocProvider.of<SettingsPageBloc>(context)
                        .add(HomeAssistantConnectionWidgetLoaded());
                  }
                },
              ),
            ],
            child: BlocBuilder<SettingsPageBloc, SettingsPageState>(
                builder: (context, state) {
              if (state is WidgetsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AllWidgetsLoaded) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        HomeAssistantAddressWidget(),
                        AccessTokenWidget(),
                        NotificationsSwitchWidget(),
                        HomeAssistantConnectionWidget(),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
          ),
        ),
      ),
    );
  }
}
