import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_event.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_state.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries _repository.dart';

class DataSharingDialogBloc
    extends Bloc<DataSharingDialogEvent, DataSharingDialogState> {
  final SmartPlugEntriesRepository smartPlugEntriesRepository;

  DataSharingDialogBloc({required this.smartPlugEntriesRepository})
      : super(DataSharingDialogClosed()) {
    on<OpenDataSharingDialog>(_mapOpenDataSharingDialogEventToState);
    on<DownloadData>(_mapDownloadDataEventToState);
  }

  void _mapOpenDataSharingDialogEventToState(
      OpenDataSharingDialog event, Emitter<DataSharingDialogState> emit) async {
      emit(DataSharingDialogOpen());
    //Share.share('Hello Welcome to FlutterCampus', subject: 'Welcome Message');
  }

  void _mapOpenDataSharingDialogEventToState(
      OpenDataSharingDialog event, Emitter<DataSharingDialogState> emit) async {
    emit(DataSharingDialogOpen());
    //Share.share('Hello Welcome to FlutterCampus', subject: 'Welcome Message');
  }

  void _mapDownloadDataEventToState(
      DownloadData event, Emitter<DataSharingDialogState> emit) async {
    emit(DataSharingDialogClosed());
  }
}
