import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_event.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_state.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_event.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_state.dart';

class SmartPlugEntriesListWidget extends StatelessWidget {
  const SmartPlugEntriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SmartPlugEntryDialogBloc, SmartPlugEntryDialogState>(
      listener: (context, state) {
        if (state is SmartPlugEntryUpdated || state is SmartPlugEntryDeleted) {
          BlocProvider.of<SmartPlugEntriesBloc>(context)
              .add(FetchSmartPlugEntries());
        }
      },
      child: Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<SmartPlugEntriesBloc>(context)
                .add(FetchSmartPlugEntries());
          },
          child: BlocBuilder<SmartPlugEntriesBloc, SmartPlugEntriesState>(
            builder: (context, state) {
              if (state is SmartPlugEntriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SmartPlugEntriesLoaded) {
                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.entries.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final entry = state.entries[index];
                    return ListTile(
                        title: Text(
                          '${entry.homeAssistantEntityId}'
                          '\n${entry.timeStamp}',
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'State: ${entry.state}',
                            ),
                            Text(
                              'Device Class: ${entry.deviceClass}',
                            ),
                            Text(
                              'Label: ${entry.label}',
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            BlocProvider.of<SmartPlugEntryDialogBloc>(context)
                                .add(OpenSmartPlugEntryDialog(entry));
                          },
                        ));
                  },
                );
              } else if (state is SmartPlugEntriesError) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Error: ${state.errorMessage}',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is SmartPlugEntriesEmpty) {
                return const CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Center(child: Text('No entries yet.'))),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox(); // Initial state
              }
            },
          ),
        ),
      ),
    );
  }
}
