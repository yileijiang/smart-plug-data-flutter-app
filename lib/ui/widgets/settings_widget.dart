import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_state.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_state.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_bloc.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_event.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_state.dart';
import 'package:smart_plug_data/ui/widgets/access_token_widget.dart';
import 'package:smart_plug_data/ui/widgets/home_assistant_address_widget.dart';
import 'package:smart_plug_data/ui/widgets/home_assistant_connection_widget.dart';
import 'package:smart_plug_data/ui/widgets/push_notifications_switch_widget.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeAssistantAddressBloc, HomeAssistantAddressState>(
          listener: (context, state) {
            if (state is HomeAssistantAddressUpdated) {
              BlocProvider.of<SettingsBloc>(context).add(LoadSettings());
            }
          },
        ),
        BlocListener<AccessTokenBloc, AccessTokenState>(
          listener: (context, state) {
            if (state is AccessTokenUpdated) {
              BlocProvider.of<SettingsBloc>(context).add(LoadSettings());
            }
          },
        ),
        BlocListener<PushNotificationsSettingBloc, PushNotificationsSettingState>(
          listener: (context, state) {
            if (state is PushNotificationsSettingUpdated) {
              BlocProvider.of<SettingsBloc>(context).add(LoadSettings());
            }
          },
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  HomeAssistantAddressWidget(
                      homeAssistantAddress: state.homeAssistantAddress),
                  AccessTokenWidget(
                      accessToken: state.accessToken),
                  PushNotificationsSwitchWidget(pushNotificationsBool: state.pushNotificationsBool),
                  HomeAssistantConnectionWidget(connectionEstablished: true),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
