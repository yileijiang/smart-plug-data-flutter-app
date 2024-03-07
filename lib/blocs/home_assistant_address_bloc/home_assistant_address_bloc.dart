import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_state.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_event.dart';
import 'package:smart_plug_data/blocs/push_notifications_setting_bloc/push_notifications_setting_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';

class HomeAssistantAddressBloc
    extends Bloc<HomeAssistantAddressEvent, HomeAssistantAddressState> {
  final SettingsRepository settingsRepository;

  HomeAssistantAddressBloc({required this.settingsRepository})
      : super(HomeAssistantAddressReadOnly()) {
    on<EditHomeAssistantAddress>(_mapEditHomeAssistantAddressEventToState);
    on<SaveHomeAssistantAddress>(_mapSaveHomeAssistantAddressEventToState);
  }

  void _mapEditHomeAssistantAddressEventToState(
      EditHomeAssistantAddress event, Emitter<HomeAssistantAddressState> emit) async {
    emit(HomeAssistantAddressEditing(event.homeAssistantAddress));
  }

  void _mapSaveHomeAssistantAddressEventToState(
      SaveHomeAssistantAddress event, Emitter<HomeAssistantAddressState> emit) async {
    await settingsRepository.saveHomeAssistantAddress(event.homeAssistantAddress);
    emit(HomeAssistantAddressUpdated());
    emit(HomeAssistantAddressReadOnly());
  }


}
