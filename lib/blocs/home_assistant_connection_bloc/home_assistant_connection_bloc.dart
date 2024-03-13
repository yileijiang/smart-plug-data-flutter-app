import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class HomeAssistantConnectionBloc
    extends Bloc<HomeAssistantConnectionEvent, HomeAssistantConnectionState> {
  final SettingsRepository settingsRepository;

  HomeAssistantConnectionBloc({required this.settingsRepository})
      : super(ConnectionStatusLoading()) {
    on<LoadConnectionStatus>(_mapLoadConnectionStatusEventToState);
    on<EstablishConnectionToHomeAssistantAPI>(
        _mapEstablishConnectionToHomeAssistantAPIEventToState);
    on<UpdateConnectionStatusToConnected>(
        _mapUpdateConnectionStatusToConnectedEventToState);
    on<TerminateConnectionToHomeAssistantAPI>(
        _mapTerminateConnectionToHomeAssistantAPIEventToState);
  }

  void _mapLoadConnectionStatusEventToState(LoadConnectionStatus event,
      Emitter<HomeAssistantConnectionState> emit) async {
    try {
      final connectionStatusBool =
          await settingsRepository.getConnectionStatus();
      if (connectionStatusBool == false) {
        if (await FlutterForegroundTask.isRunningService) {
          emit(Connecting());
        } else {
          emit(NoConnection());
        }
      } else {
        emit(Connected());
      }
    } catch (e) {
      emit(NoConnection());
      ToastUtils.showErrorToast('Error loading connection status');
    }
  }

  Future<void> _mapEstablishConnectionToHomeAssistantAPIEventToState(
      // TODO: navigate to other page and back while connecting throws error
      EstablishConnectionToHomeAssistantAPI event,
      Emitter<HomeAssistantConnectionState> emit) async {
    emit(Connecting());
    await GetIt.instance<ForegroundTaskService>().startForegroundTask();

    final receivePort =
        GetIt.instance<ForegroundTaskService>().getReceivePort();

     receivePort?.listen((message) async {
      if (message is Map) {
        if (message.containsKey('connection_error')) {
          String errorMessage = message['connection_error'];
          ToastUtils.showErrorToast(errorMessage);
          add(TerminateConnectionToHomeAssistantAPI());
        } else if (message.containsKey('auth_error')) {
          String errorMessage = message['auth_error'];
          ToastUtils.showErrorToast(errorMessage);
          add(TerminateConnectionToHomeAssistantAPI());
        } else if (message.containsKey('auth_ok')) {
          String successMessage = message['auth_ok'];
          add(UpdateConnectionStatusToConnected());
          ToastUtils.showSuccessToast(successMessage);
        }
      }
    });
  }

  void _mapUpdateConnectionStatusToConnectedEventToState(UpdateConnectionStatusToConnected event,
      Emitter<HomeAssistantConnectionState> emit) async {
    await settingsRepository.saveConnectionStatus(true);
    emit(Connected());
  }

  void _mapTerminateConnectionToHomeAssistantAPIEventToState(
      TerminateConnectionToHomeAssistantAPI event,
      Emitter<HomeAssistantConnectionState> emit) async {
    GetIt.instance<ForegroundTaskService>().stopForegroundTask();
    await settingsRepository.saveConnectionStatus(false);
    emit(NoConnection());
  }
}
