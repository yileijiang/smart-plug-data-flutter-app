import 'package:drift/drift.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_event.dart';
import 'package:smart_plug_data/blocs/registered_smart_plug_dialog_bloc/registered_smart_plug_dialog_state.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class RegisteredSmartPlugDialogBloc extends Bloc<RegisteredSmartPlugDialogEvent,
    RegisteredSmartPlugDialogState> {
  final RegisteredSmartPlugsRepository registeredSmartPlugsRepository;

  RegisteredSmartPlugDialogBloc({required this.registeredSmartPlugsRepository})
      : super(RegisteredSmartPlugDialogClosed()) {
    on<OpenRegisteredSmartPlugDialog>(
        _mapOpenRegisteredSmartPlugDialogEventToState);
    on<UpdateRegisteredSmartPlug>(_mapUpdateRegisteredSmartPlugEventToState);
    on<DeleteRegisteredSmartPlug>(_mapDeleteRegisteredSmartPlugEventToState);
  }

  void _mapOpenRegisteredSmartPlugDialogEventToState(
      OpenRegisteredSmartPlugDialog event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    emit(RegisteredSmartPlugDialogOpen(event.registeredSmartPlug));
  }

  void _mapUpdateRegisteredSmartPlugEventToState(
      UpdateRegisteredSmartPlug event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    try {
      await registeredSmartPlugsRepository.updateRegisteredSmartPlug(
          event.registeredSmartPlug,
          event.homeAssistantEntityId,
          event.deviceClassAttribute,
          event.getNotificationsBoolean);
      emit(RegisteredSmartPlugUpdated());
      ToastUtils.showSuccessToast('Smart plug updated');
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        ToastUtils.showErrorToast('Error: Home Assistant Entity Id already exists');
      } else {
        ToastUtils.showErrorToast('Error updating smart plug');
      }
    }
  }

  void _mapDeleteRegisteredSmartPlugEventToState(
      DeleteRegisteredSmartPlug event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    /*
    try {
      await smartPlugEntriesRepository
          .deleteSmartPlugEntry(event.smartPlugEntry);
      emit(SmartPlugEntryDeleted());
      ToastUtils.showSuccessToast('Entry deleted');
    } catch (e) {
      ToastUtils.showErrorToast('Error deleting entry');
    }
  }
     */
  }
}
