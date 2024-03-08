import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class PushNotificationsSettingBloc
    extends Bloc<PushNotificationsSettingEvent, PushNotificationsSettingState> {
  final SettingsRepository settingsRepository;

  PushNotificationsSettingBloc({required this.settingsRepository})
      : super(PushNotificationsSettingLoading()) {
    on<LoadPushNotificationsSetting>(_mapLoadPushNotificationsSettingEventToState);
    on<TogglePushNotificationsSwitch>(_mapTogglePushNotificationsSwitchEventToState);
  }

  void _mapLoadPushNotificationsSettingEventToState(
      LoadPushNotificationsSetting event, Emitter<PushNotificationsSettingState> emit) async {
    try {
      final pushNotificationsBool = await settingsRepository.getPushNotificationsSetting();
      emit(PushNotificationsSettingLoaded(pushNotificationsBool));
    } catch (e) {
      emit(PushNotificationsSettingLoaded(false));
      ToastUtils.showErrorToast('Error loading push notifications setting');
    }
  }

  void _mapTogglePushNotificationsSwitchEventToState(
      TogglePushNotificationsSwitch event, Emitter<PushNotificationsSettingState> emit) async {
    try {
      await settingsRepository.savePushNotificationsSetting(event.pushNotificationsBool);
      emit(PushNotificationsSettingLoaded(event.pushNotificationsBool));
      ToastUtils.showSuccessToast('Push notifications setting updated');
    } catch (e) {
      ToastUtils.showErrorToast('Error updating push notifications setting');
    }

  }
}
