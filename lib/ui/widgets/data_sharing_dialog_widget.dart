import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_event.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_state.dart';

class DataSharingDialog extends StatelessWidget {
  const DataSharingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController fileNameController = TextEditingController();

    return BlocBuilder<DataSharingDialogBloc, DataSharingDialogState>(
        builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Download and Share Data'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  BlocProvider.of<DataSharingDialogBloc>(context)
                      .add(CloseDataSharingDialog());
                },
              ),
            ],
          ),
          body: Dialog.fullscreen(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: fileNameController,
                        autofocus: false,
                        canRequestFocus: true,
                        decoration: const InputDecoration(
                          labelText: 'File Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Enter File Name',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: passwordController,
                        autofocus: false,
                        canRequestFocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Encryption Password',
                          hintText: 'Enter Encryption Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 10.0),
                            const Expanded(
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Home Assistant entity Ids are anonymized. Entries are AES encrypted with the provided password, and saved in JSON format as \'file_name.aes\' in the downloads folder. Entries can be shared after downloading.',
                                      ),
                                      SizedBox(height: 10.0),
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        title: Text(
                                          'Example Entry',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        subtitle: Text(
                                            """{\n "entryId":"100",\n homeAssistantEntityId":"1", \n "timeStamp":"2023-08-25 13:10:43.000",\n "state":"9.474", \n "deviceClass":"current", \n "label":"running dishwasher" \n}"""),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  OverflowBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: (state is DataDownloadSuccess)
                            ? () {
                                final path = state.path;

                                BlocProvider.of<DataSharingDialogBloc>(context)
                                    .add(ShareData(path));
                              }
                            : null,
                        icon: const Icon(Icons.share),
                        label: const Text('Share File'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          BlocProvider.of<DataSharingDialogBloc>(context).add(
                              DownloadData(fileNameController.text,
                                  passwordController.text));
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download File'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

class DataSharingDialogWidget extends StatelessWidget {
  const DataSharingDialogWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<DataSharingDialogBloc, DataSharingDialogState>(
      listener: (context, state) {
        if (state is DataSharingDialogOpen) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext newContext) {
              return BlocProvider<DataSharingDialogBloc>.value(
                value: context.read<DataSharingDialogBloc>(),
                child: const DataSharingDialog(),
              );
            },
          );
        } else if (state is DataSharingDialogClosed) {
          Navigator.of(context).pop();
        }
      },
      child: const SizedBox(),
    );
  }
}
