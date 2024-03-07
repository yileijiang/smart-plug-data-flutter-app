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
    on<OpenEditRegisteredSmartPlugDialog>(
        _mapOpenEditRegisteredSmartPlugDialogEventToState);
    on<OpenNewRegisteredSmartPlugDialog>(
        _mapOpenNewRegisteredSmartPlugDialogEventToState);
    on<CloseRegisteredSmartPlugDialog>(
        _mapCloseRegisteredSmartPlugDialogEventToState);
    on<AddNewRegisteredSmartPlug>(_mapNewRegisteredSmartPlugEventToState);
    on<UpdateRegisteredSmartPlug>(_mapUpdateRegisteredSmartPlugEventToState);
    on<DeleteRegisteredSmartPlug>(_mapDeleteRegisteredSmartPlugEventToState);
  }

  void _mapOpenEditRegisteredSmartPlugDialogEventToState(
      OpenEditRegisteredSmartPlugDialog event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    emit(EditRegisteredSmartPlugDialogOpen(event.registeredSmartPlug));
  }

  void _mapOpenNewRegisteredSmartPlugDialogEventToState(
      OpenNewRegisteredSmartPlugDialog event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    emit(NewRegisteredSmartPlugDialogOpen());
  }

  void _mapCloseRegisteredSmartPlugDialogEventToState(
      CloseRegisteredSmartPlugDialog event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    emit(RegisteredSmartPlugDialogClosed());
  }

  void _mapNewRegisteredSmartPlugEventToState(
      AddNewRegisteredSmartPlug event,
      Emitter<RegisteredSmartPlugDialogState> emit) async {
    try {
      await registeredSmartPlugsRepository.createRegisteredSmartPlug(
          event.homeAssistantEntityId,
          event.deviceClassAttribute,
          event.getNotificationsBoolean);
      emit(NewRegisteredSmartPlugAdded());
      ToastUtils.showSuccessToast('New smart plug added');
      emit(RegisteredSmartPlugDialogClosed());
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        ToastUtils.showErrorToast('Error: Home Assistant Entity Id already exists');
      } else {
        ToastUtils.showErrorToast('Error adding new smart plug');
      }
    }
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
      emit(RegisteredSmartPlugDialogClosed());
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
    try {
      await registeredSmartPlugsRepository
          .deleteRegisteredSmartPlug(event.registeredSmartPlug);
      emit(RegisteredSmartPlugDeleted());
      ToastUtils.showSuccessToast('Entry deleted');
      emit(RegisteredSmartPlugDialogClosed());
    } catch (e) {
      ToastUtils.showErrorToast('Error deleting entry');
    }
  }

}
