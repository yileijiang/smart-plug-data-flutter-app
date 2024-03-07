import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';

class PushNotificationsSwitchWidget extends StatelessWidget {
  final bool pushNotificationsBool;

  const PushNotificationsSwitchWidget({required this.pushNotificationsBool, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PushNotificationsSettingBloc,
          PushNotificationsSettingState>(builder: (context, state) {
              return Row(
                children: [
                  const Expanded(
                    child: Text('Receive Push Notifications'),
                  ),
                  Switch(
                    value: pushNotificationsBool,
                    onChanged: (newValue) {
                      context
                          .read<PushNotificationsSettingBloc>()
                          .add(TogglePushNotificationsSwitch(newValue));
                    },
                  ),
                ],
              );
            }
    );
  }
}
