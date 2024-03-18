import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_state.dart';

class NotificationsSwitchWidget extends StatelessWidget {
  const NotificationsSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsSettingBloc, NotificationsSettingState>(
        builder: (context, state) {
      if (state is NotificationsSettingLoaded) {
        return Row(
          children: [
            Expanded(
              child: Text(
                  style: Theme.of(context).textTheme.titleMedium,
                  'Receive Notifications'),
            ),
            Switch(
              value: state.notificationsBool,
              onChanged: (newValue) {
                context
                    .read<NotificationsSettingBloc>()
                    .add(ToggleNotificationsSwitch(newValue));
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
