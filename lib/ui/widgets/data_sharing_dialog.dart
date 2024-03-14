import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_state.dart';

class DataSharingDialog extends StatelessWidget {
  final DataSharingDialogBloc dataSharingDialogBloc;

  const DataSharingDialog({
    required this.dataSharingDialogBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController fileNameController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Download and Share Data'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
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
                Column(children: [
                  TextField(
                    controller: fileNameController,
                    autofocus: false,
                    canRequestFocus: true,
                    decoration: const InputDecoration(
                      labelText: 'File Name',
                      hintText: 'Enter File Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
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
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],),

                const Flexible(
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'Home Assistant Entity Ids are anonymized. Entries are AES encrypted with the provided password, and saved in JSON format as \'file_name.aes\' in the downloads folder.',
                                    ),
                                    SizedBox(height: 10.0),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      title: Text(
                                        'Example Entry',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          // TODO: change data to proper entry
                                          Text(
                                              """{\n "entryId":"100",\n homeAssistantEntityId":"1", \n "timeStamp":"2023-12-25 13:10:43.794179",\n "state":"9.474", \n "deviceClass":"current", \n "label":"" \n}"""),
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
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Download File'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      label: const Text('Share File'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
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
              return DataSharingDialog(
                dataSharingDialogBloc:
                    BlocProvider.of<DataSharingDialogBloc>(context),
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
