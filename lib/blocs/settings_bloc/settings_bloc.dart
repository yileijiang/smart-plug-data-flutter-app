import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_event.dart';
import 'package:smart_plug_data/blocs/settings_bloc/settings_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';

class SettingsBloc
    extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc({required this.settingsRepository})
      : super(SettingsLoading()) {
    on<LoadSettings>(_mapLoadSettingsEventToState);
  }

  void _mapLoadSettingsEventToState(
      LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      final homeAssistantAddress = await settingsRepository.getHomeAssistantAddress();
      final accessToken = await settingsRepository.getAccessToken();
      final pushNotificationsBool = await settingsRepository.getPushNotificationsSetting();


      emit(SettingsLoaded(homeAssistantAddress, accessToken, pushNotificationsBool));
    } catch (e) {
      emit(SettingsError('Failed to load settings: $e'));
    }

  }

}
