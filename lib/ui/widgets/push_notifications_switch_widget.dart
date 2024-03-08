import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';

class PushNotificationsSwitchWidget extends StatelessWidget {
  const PushNotificationsSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PushNotificationsSettingBloc,
        PushNotificationsSettingState>(builder: (context, state) {
      if (state is PushNotificationsSettingLoaded) {
        return Row(
          children: [
            const Expanded(
              child: Text('Receive Push Notifications'),
            ),
            Switch(
              value: state.pushNotificationsBool,
              onChanged: (newValue) {
                context
                    .read<PushNotificationsSettingBloc>()
                    .add(TogglePushNotificationsSwitch(newValue));
              },
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
