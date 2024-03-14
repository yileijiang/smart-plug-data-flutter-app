import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_event.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_state.dart';

class DataSharingButton extends StatelessWidget {
  const DataSharingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataSharingDialogBloc, DataSharingDialogState>(
        builder: (context, state) {
      return FloatingActionButton(
        onPressed: () {
          context.read<DataSharingDialogBloc>().add(OpenDataSharingDialog());
        },
        tooltip: 'Share Data',
        child: const Icon(Icons.download),
      );
    });
  }
}
