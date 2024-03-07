import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';

class HomeAssistantConnectionWidget extends StatelessWidget {
  final bool connectionEstablished;

  const HomeAssistantConnectionWidget({required this.connectionEstablished, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAssistantConnectionBloc, PushNotificationsSettingState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Home Assistant API Connection',
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Status: No Connection'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add onPressed functionality here
                  },
                  child: const Text('Disconnect'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
