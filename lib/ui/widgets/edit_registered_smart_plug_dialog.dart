import 'package:flutter/material.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_event.dart';
import 'package:smart_plug_data/data/database/database.dart';

class EditRegisteredSmartPlugDialog extends StatefulWidget {
  final RegisteredSmartPlugDialogBloc registeredSmartPlugDialogBloc;
  final RegisteredSmartPlug registeredSmartPlug;

  const EditRegisteredSmartPlugDialog({
    required this.registeredSmartPlugDialogBloc,
    required this.registeredSmartPlug,
    super.key,
  });

  @override
  EditRegisteredSmartPlugDialogState createState() =>
      EditRegisteredSmartPlugDialogState();
}

class EditRegisteredSmartPlugDialogState
    extends State<EditRegisteredSmartPlugDialog> {
  late TextEditingController homeAssistantEntityIdController;
  late TextEditingController deviceClassAttributeController;
  late bool getNotificationsBoolean;

  @override
  void initState() {
    super.initState();
    homeAssistantEntityIdController = TextEditingController(
        text: widget.registeredSmartPlug.homeAssistantEntityId);
    deviceClassAttributeController = TextEditingController(
        text: widget.registeredSmartPlug.deviceClassAttribute);
    getNotificationsBoolean = widget.registeredSmartPlug.getNotifications;
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
      title: const Text('Edit Smart Plug'),
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
            TextButton.icon(
              onPressed: () {
                widget.registeredSmartPlugDialogBloc.add(
                  DeleteRegisteredSmartPlug(widget.registeredSmartPlug),
                );
              },
              icon: const Icon(Icons.delete),
              label: const Text('Delete Entry'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                overlayColor: Colors.transparent,
              ),
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
              UpdateRegisteredSmartPlug(
                  widget.registeredSmartPlug,
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
