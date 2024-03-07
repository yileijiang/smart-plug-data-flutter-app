import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';

class PushNotificationsSettingBloc
    extends Bloc<PushNotificationsSettingEvent, PushNotificationsSettingState> {
  final SettingsRepository settingsRepository;

  PushNotificationsSettingBloc({required this.settingsRepository})
      : super(PushNotificationsSettingInitialState()) {
    on<TogglePushNotificationsSwitch>(_mapTogglePushNotificationsSwitchEventToState);
  }

  void _mapTogglePushNotificationsSwitchEventToState(
      TogglePushNotificationsSwitch event, Emitter<PushNotificationsSettingState> emit) async {
      await settingsRepository.savePushNotificationsSetting(event.pushNotificationsBool);
      emit(PushNotificationsSettingUpdated());
  }
}
