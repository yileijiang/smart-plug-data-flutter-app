import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_event.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_bloc.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries _repository.dart';
import 'package:smart_plug_data/ui/widgets/menu_app_bar_widget.dart';
import 'package:smart_plug_data/ui/widgets/smart_plug_entries_list_widget.dart';
import 'package:smart_plug_data/ui/widgets/smart_plug_entry_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SmartPlugEntriesRepository>(
      create: (context) => SmartPlugEntriesRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SmartPlugEntriesBloc>(
            create: (context) => SmartPlugEntriesBloc(
              smartPlugEntriesRepository:
                  context.read<SmartPlugEntriesRepository>(),
            )..add(FetchSmartPlugEntries()),
          ),
          BlocProvider<SmartPlugEntryDialogBloc>(
            create: (context) => SmartPlugEntryDialogBloc(
              smartPlugEntriesRepository:
              context.read<SmartPlugEntriesRepository>(),
            ),
          ),
        ],
        child: const Scaffold(
          appBar: MenuAppBarWidget(
            title: 'Smart Plug Data Entries',
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SmartPlugEntriesListWidget(),
                SmartPlugEntryDialogWidget(),

              ],
            ),
          ),
          /*
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),

       */
        ),
      ),
    );
  }
}
