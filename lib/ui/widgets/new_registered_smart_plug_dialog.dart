import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_event.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_state.dart';

class NewRegisteredSmartPlugDialog extends StatefulWidget {
  final RegisteredSmartPlugDialogBloc registeredSmartPlugDialogBloc;

  const NewRegisteredSmartPlugDialog({
    required this.registeredSmartPlugDialogBloc,
    super.key,
  });

  @override
  NewRegisteredSmartPlugDialogState createState() =>
      NewRegisteredSmartPlugDialogState();
}

class NewRegisteredSmartPlugDialogState
    extends State<NewRegisteredSmartPlugDialog> {
  late TextEditingController homeAssistantEntityIdController;
  late TextEditingController deviceClassAttributeController;
  late bool getNotificationsBoolean;

  @override
  void initState() {
    super.initState();
    homeAssistantEntityIdController = TextEditingController();
    deviceClassAttributeController = TextEditingController();
    getNotificationsBoolean = false;
  }

  @override
  void dispose() {
    homeAssistantEntityIdController.dispose();
    deviceClassAttributeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Smart Plug'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: homeAssistantEntityIdController,
              decoration:
              const InputDecoration(labelText: 'Home Assistant Entity Id'),
            ),
            TextField(
              controller: deviceClassAttributeController,
              decoration:
              const InputDecoration(labelText: 'Device Class Attribute'),
            ),
            Row(
              children: [
                const Text('Receive Notifications'),
                Checkbox(
                  value: getNotificationsBoolean,
                  onChanged: (bool? value) {
                    setState(() {
                      getNotificationsBoolean = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.registeredSmartPlugDialogBloc.add(
              CloseRegisteredSmartPlugDialog(),
            );
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.registeredSmartPlugDialogBloc.add(
              AddNewRegisteredSmartPlug(
                  homeAssistantEntityIdController.text,
                  deviceClassAttributeController.text,
                  getNotificationsBoolean),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class RegisteredSmartPlugDialogWidget extends StatelessWidget {
  const RegisteredSmartPlugDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisteredSmartPlugDialogBloc,
        RegisteredSmartPlugDialogState>(
      listener: (context, state) {
        if (state is NewRegisteredSmartPlugDialogOpen) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext newContext) {
              return NewRegisteredSmartPlugDialog(
                registeredSmartPlugDialogBloc:
                BlocProvider.of<RegisteredSmartPlugDialogBloc>(context),
              );
            },
          );
        } else if (state is RegisteredSmartPlugDialogClosed) {
          Navigator.of(context).pop();
        }
      },
      child: const SizedBox(),
    );
  }
}
