import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_connection_bloc/home_assistant_connection_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';

class HomeAssistantConnectionBloc
    extends Bloc<HomeAssistantConnectionEvent, HomeAssistantConnectionState> {
  final SettingsRepository settingsRepository;

  HomeAssistantConnectionBloc({required this.settingsRepository})
      : super(NoConnection()) {
    on<EstablishConnectionToHomeAssistantAPI>(_mapEstablishConnectionToHomeAssistantAPIEventToState);
    on<TerminateConnectionToHomeAssistantAPI>(_mapTerminateConnectionToHomeAssistantAPIEventToState);
  }

  void _mapEstablishConnectionToHomeAssistantAPIEventToState(
      EstablishConnectionToHomeAssistantAPI event, Emitter<HomeAssistantConnectionState> emit) async {
  }

  void _mapTerminateConnectionToHomeAssistantAPIEventToState(
      TerminateConnectionToHomeAssistantAPI event, Emitter<HomeAssistantConnectionState> emit) async {
  }
}
