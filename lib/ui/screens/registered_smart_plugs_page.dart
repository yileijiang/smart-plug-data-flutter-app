import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_event.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';
import 'package:smart_plug_data/ui/widgets/registered_smart_plug_dialog_widget.dart';
import 'package:smart_plug_data/ui/widgets/new_registered_smart_plug_button.dart';
import 'package:smart_plug_data/ui/widgets/registered_smart_plugs_list_widget.dart';

class RegisteredSmartPlugsPage extends StatelessWidget {
  const RegisteredSmartPlugsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<RegisteredSmartPlugsRepository>(
      create: (context) => RegisteredSmartPlugsRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegisteredSmartPlugsBloc>(
            create: (context) => RegisteredSmartPlugsBloc(
              registeredSmartPlugsRepository:
                  context.read<RegisteredSmartPlugsRepository>(),
            )..add(FetchRegisteredSmartPlugs()),
          ),
          BlocProvider<RegisteredSmartPlugDialogBloc>(
            create: (context) => RegisteredSmartPlugDialogBloc(
              registeredSmartPlugsRepository:
                  context.read<RegisteredSmartPlugsRepository>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Registered Smart Plugs'),
          ),
          body: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RegisteredSmartPlugsListWidget(),
                RegisteredSmartPlugDialogWidget(),
              ],
            ),
          ),
          floatingActionButton: const NewRegisteredSmartPlugButton(),
        ),
      ),
    );
  }
}
