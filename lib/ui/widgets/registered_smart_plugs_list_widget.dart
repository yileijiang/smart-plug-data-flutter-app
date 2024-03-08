import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_event.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_state.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_event.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_state.dart';

class RegisteredSmartPlugsListWidget extends StatelessWidget {
  const RegisteredSmartPlugsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisteredSmartPlugDialogBloc, RegisteredSmartPlugDialogState>(
      listener: (context, state) {
        if (state is RegisteredSmartPlugUpdated || state is RegisteredSmartPlugDeleted || state is NewRegisteredSmartPlugAdded) {
          BlocProvider.of<RegisteredSmartPlugsBloc>(context).add(FetchRegisteredSmartPlugs());
        }
      },
      child: BlocBuilder<RegisteredSmartPlugsBloc, RegisteredSmartPlugsState>(
        builder: (context, state) {
          if (state is RegisteredSmartPlugsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RegisteredSmartPlugsLoaded) {
            return Expanded(
              child: ListView.separated(
                itemCount: state.registeredSmartPlugs.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final smartPlug = state.registeredSmartPlugs[index];
                  return ListTile(
                      title: Text(
                        smartPlug.homeAssistantEntityId
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Device Class Attribute: ${smartPlug.deviceClassAttribute}',
                          ),
                          Row(
                            children: [
                              Text(
                                smartPlug.getNotifications ? 'Notifications active' : 'Notifications inactive',
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                                smartPlug.getNotifications ? Icons.notifications_active : Icons.notifications_off,
                              ),
                            ],
                          )

                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          BlocProvider.of<RegisteredSmartPlugDialogBloc>(context)
                              .add(OpenEditRegisteredSmartPlugDialog(smartPlug));
                        },
                      ));
                },
              ),
            );
          } else if (state is RegisteredSmartPlugsError) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Error: ${state.errorMessage}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (state is RegisteredSmartPlugsEmpty) {
            return const Text('No smart plugs registered yet.');
          } else {
            return const SizedBox(); // Initial state
          }
        },
      ),
    );
  }
}
