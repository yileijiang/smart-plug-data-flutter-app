import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_event.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_state.dart';
import 'package:smart_plug_data/data/database/database.dart';

class SmartPlugEntryDialog extends StatelessWidget {
  final SmartPlugEntryDialogBloc smartPlugEntryDialogBloc;
  final SmartPlugEntry smartPlugEntry;

  const SmartPlugEntryDialog({
    required this.smartPlugEntryDialogBloc,
    required this.smartPlugEntry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController labelController =
        TextEditingController(text: smartPlugEntry.label);

    return AlertDialog(
      title: const Text(
        'Edit Smart Plug Entry',
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${smartPlugEntry.homeAssistantEntityId}'
              '\n${smartPlugEntry.timeStamp}',
            ),
            Text(
              'State: ${smartPlugEntry.state}',
            ),
            Text(
              'Device Class: ${smartPlugEntry.deviceClass}',
            ),
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label'),
            ),
            TextButton.icon(
              onPressed: () {
                smartPlugEntryDialogBloc.add(
                  DeleteSmartPlugEntry(smartPlugEntry),
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
            smartPlugEntryDialogBloc.add(
              CloseSmartPlugEntryDialog(),
            );
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            smartPlugEntryDialogBloc.add(
              UpdateSmartPlugEntry(smartPlugEntry, labelController.text),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class SmartPlugEntryDialogWidget extends StatelessWidget {
  const SmartPlugEntryDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<SmartPlugEntryDialogBloc, SmartPlugEntryDialogState>(
        listener: (context, state) {
          if (state is SmartPlugEntryDialogOpen) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext newContext) {
                return SmartPlugEntryDialog(
                  smartPlugEntryDialogBloc:
                      BlocProvider.of<SmartPlugEntryDialogBloc>(context),
                  smartPlugEntry: state.smartPlugEntry,
                );
              },
            );
          } else if (state is SmartPlugEntryDialogClosed) {
            Navigator.of(context).pop();
          }
        },
        child: const SizedBox());
  }
}
