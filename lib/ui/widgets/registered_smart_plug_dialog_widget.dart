import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_state.dart';
import 'package:smart_plug_data/ui/widgets/edit_registered_smart_plug_dialog.dart';
import 'package:smart_plug_data/ui/widgets/new_registered_smart_plug_dialog.dart';

class RegisteredSmartPlugDialogWidget extends StatelessWidget {
  const RegisteredSmartPlugDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisteredSmartPlugDialogBloc,
        RegisteredSmartPlugDialogState>(
      listener: (context, state) {
        if (state is EditRegisteredSmartPlugDialogOpen) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext newContext) {
              return BlocProvider<RegisteredSmartPlugDialogBloc>.value(
                value: context.read<RegisteredSmartPlugDialogBloc>(),
                child: EditRegisteredSmartPlugDialog(
                  registeredSmartPlug: state.registeredSmartPlug,
                ),
              );
            },
          );
        } else if (state is NewRegisteredSmartPlugDialogOpen) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext newContext) {
              return BlocProvider<RegisteredSmartPlugDialogBloc>.value(
                value: context.read<RegisteredSmartPlugDialogBloc>(),
                child: const NewRegisteredSmartPlugDialog(),
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
