import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_state.dart';

class HomeAssistantConnectionWidget extends StatelessWidget {
  const HomeAssistantConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              style: Theme.of(context).textTheme.titleMedium,
              'Home Assistant API Connection',
            ),
          ],
        ),
        BlocBuilder<HomeAssistantConnectionBloc, HomeAssistantConnectionState>(
            builder: (context, state) {
          if (state is NoConnection) {
            return Row(
              children: [
                const Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.error_outline),
                      SizedBox(width: 8),
                      Text('Status: No Connection'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<HomeAssistantConnectionBloc>(context)
                        .add(EstablishConnectionToHomeAssistantAPI());
                  },
                  child: const Text('Connect'),
                ),
              ],
            );
          } else if (state is Connecting) {
            return Row(
              children: [
                const Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.change_circle_outlined),
                      SizedBox(width: 8),
                      Text('Status: Connecting'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<HomeAssistantConnectionBloc>(context)
                        .add(TerminateConnectionToHomeAssistantAPI());
                  },
                  child: const Text('Disconnect'),
                ),
              ],
            );
          } else if (state is Connected) {
            return Row(
              children: [
                const Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline),
                      SizedBox(width: 8),
                      Text('Status: Connected'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<HomeAssistantConnectionBloc>(context)
                        .add(TerminateConnectionToHomeAssistantAPI());
                  },
                  child: const Text('Disconnect'),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}
