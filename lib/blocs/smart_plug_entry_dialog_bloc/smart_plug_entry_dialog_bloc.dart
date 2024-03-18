import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_event.dart';
import 'package:smart_plug_data/blocs/smart_plug_entry_dialog_bloc/smart_plug_entry_dialog_state.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries _repository.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class SmartPlugEntryDialogBloc
    extends Bloc<SmartPlugEntryDialogEvent, SmartPlugEntryDialogState> {
  final SmartPlugEntriesRepository smartPlugEntriesRepository;

  SmartPlugEntryDialogBloc({required this.smartPlugEntriesRepository})
      : super(SmartPlugEntryDialogClosed()) {
    on<OpenSmartPlugEntryDialog>(_mapOpenSmartPlugEntryDialogEventToState);
    on<OpenSmartPlugEntryDialogFromNotification>(
        _mapOpenSmartPlugEntryDialogFromNotificationEventToState);
    on<CloseSmartPlugEntryDialog>(_mapCloseSmartPlugEntryDialogEventToState);
    on<UpdateSmartPlugEntry>(_mapUpdateSmartPlugEntryEventToState);
    on<DeleteSmartPlugEntry>(_mapDeleteSmartPlugEntryEventToState);
  }

  void _mapOpenSmartPlugEntryDialogEventToState(OpenSmartPlugEntryDialog event,
      Emitter<SmartPlugEntryDialogState> emit) async {
    emit(SmartPlugEntryDialogOpen(event.smartPlugEntry));
  }

  void _mapOpenSmartPlugEntryDialogFromNotificationEventToState(
      OpenSmartPlugEntryDialogFromNotification event,
      Emitter<SmartPlugEntryDialogState> emit) async {
    int entryId = int.parse(event.payload!);
    SmartPlugEntry? smartPlugEntry =
        await smartPlugEntriesRepository.getSmartPlugEntryByEntryId(entryId);

    if (smartPlugEntry != null) {
      emit(SmartPlugEntryDialogOpen(smartPlugEntry));
    }
  }

  void _mapCloseSmartPlugEntryDialogEventToState(
      CloseSmartPlugEntryDialog event,
      Emitter<SmartPlugEntryDialogState> emit) async {
    emit(SmartPlugEntryDialogClosed());
  }

  void _mapUpdateSmartPlugEntryEventToState(UpdateSmartPlugEntry event,
      Emitter<SmartPlugEntryDialogState> emit) async {
    try {
      await smartPlugEntriesRepository.updateSmartPlugEntry(
          event.smartPlugEntry, event.newLabel);
      emit(SmartPlugEntryUpdated());
      ToastUtils.showSuccessToast('Entry saved');
      emit(SmartPlugEntryDialogClosed());
    } catch (e) {
      ToastUtils.showErrorToast('Error saving entry');
    }
  }

  void _mapDeleteSmartPlugEntryEventToState(DeleteSmartPlugEntry event,
      Emitter<SmartPlugEntryDialogState> emit) async {
    try {
      await smartPlugEntriesRepository
          .deleteSmartPlugEntry(event.smartPlugEntry);
      emit(SmartPlugEntryDeleted());
      ToastUtils.showSuccessToast('Entry deleted');
      emit(SmartPlugEntryDialogClosed());
    } catch (e) {
      ToastUtils.showErrorToast('Error deleting entry');
    }
  }
}
