import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/notifications_setting_bloc/notifications_setting_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class NotificationsSettingBloc
    extends Bloc<NotificationsSettingEvent, NotificationsSettingState> {
  final SettingsRepository settingsRepository;

  NotificationsSettingBloc({required this.settingsRepository})
      : super(NotificationsSettingLoading()) {
    on<LoadNotificationsSetting>(_mapLoadNotificationsSettingEventToState);
    on<ToggleNotificationsSwitch>(_mapToggleNotificationsSwitchEventToState);
  }

  void _mapLoadNotificationsSettingEventToState(
      LoadNotificationsSetting event, Emitter<NotificationsSettingState> emit) async {
    try {
      final notificationsBool = await settingsRepository.getNotificationsSetting();
      emit(NotificationsSettingLoaded(notificationsBool));
    } catch (e) {
      emit(NotificationsSettingLoaded(false));
      ToastUtils.showErrorToast('Error loading notifications setting');
    }
  }

  void _mapToggleNotificationsSwitchEventToState(
      ToggleNotificationsSwitch event, Emitter<NotificationsSettingState> emit) async {
    try {
      await settingsRepository.saveNotificationsSetting(event.notificationsBool);
      emit(NotificationsSettingLoaded(event.notificationsBool));
      ToastUtils.showSuccessToast('Notifications setting updated');
    } catch (e) {
      ToastUtils.showErrorToast('Error updating notifications setting');
    }

  }
}
