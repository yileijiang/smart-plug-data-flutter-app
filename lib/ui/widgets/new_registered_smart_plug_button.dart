import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_event.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_state.dart';

class NewRegisteredSmartPlugButton extends StatelessWidget {
  const NewRegisteredSmartPlugButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisteredSmartPlugDialogBloc,
        RegisteredSmartPlugDialogState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            BlocProvider.of<RegisteredSmartPlugDialogBloc>(context)
                .add(OpenNewRegisteredSmartPlugDialog());
          },
          tooltip: 'Register New Smart Plug',
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
