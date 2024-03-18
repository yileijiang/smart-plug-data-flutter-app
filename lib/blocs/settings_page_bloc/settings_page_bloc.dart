import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/settings_page_bloc/settings_page_event.dart';
import 'package:smart_plug_data/blocs/settings_page_bloc/settings_page_state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  bool homeAssistantAddressLoaded = false;
  bool accessTokenLoaded = false;
  bool pushNotificationsSettingLoaded = false;
  bool homeAssistantConnectionLoaded = false;

  SettingsPageBloc() : super(WidgetsLoading()) {
    on<HomeAssistantAddressWidgetLoaded>(
        _mapHomeAssistantAddressWidgetLoadedEventToState);
    on<AccessTokenWidgetLoaded>(_mapAccessTokenWidgetLoadedEventToState);
    on<PushNotificationsSettingWidgetLoaded>(
        _mapPushNotificationsSettingWidgetLoadedEventToState);
    on<HomeAssistantConnectionWidgetLoaded>(
        _mapHomeAssistantConnectionWidgetLoadedEventToState);
  }

  void _mapHomeAssistantAddressWidgetLoadedEventToState(
      HomeAssistantAddressWidgetLoaded event,
      Emitter<SettingsPageState> emit) async {
    homeAssistantAddressLoaded = true;
    areAllWidgetsLoaded();
  }

  void _mapAccessTokenWidgetLoadedEventToState(
      AccessTokenWidgetLoaded event, Emitter<SettingsPageState> emit) async {
    accessTokenLoaded = true;
    areAllWidgetsLoaded();
  }

  void _mapPushNotificationsSettingWidgetLoadedEventToState(
      PushNotificationsSettingWidgetLoaded event,
      Emitter<SettingsPageState> emit) async {
    pushNotificationsSettingLoaded = true;
    areAllWidgetsLoaded();
  }

  void _mapHomeAssistantConnectionWidgetLoadedEventToState(
      HomeAssistantConnectionWidgetLoaded event,
      Emitter<SettingsPageState> emit) async {
    homeAssistantConnectionLoaded = true;
    areAllWidgetsLoaded();
  }

  void areAllWidgetsLoaded() {
    if (homeAssistantAddressLoaded &&
        accessTokenLoaded &&
        pushNotificationsSettingLoaded &&
        homeAssistantConnectionLoaded) {
      emit(AllWidgetsLoaded());
    }
  }
}
