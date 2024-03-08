import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_event.dart';
import 'package:smart_plug_data/blocs/home_assistant_address_bloc/home_assistant_address_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class HomeAssistantAddressBloc
    extends Bloc<HomeAssistantAddressEvent, HomeAssistantAddressState> {
  final SettingsRepository settingsRepository;

  HomeAssistantAddressBloc({required this.settingsRepository})
      : super(HomeAssistantAddressLoading()) {
    on<LoadHomeAssistantAddress>(_mapLoadHomeAssistantAddressEventToState);
    on<EditHomeAssistantAddress>(_mapEditHomeAssistantAddressEventToState);
    on<SaveHomeAssistantAddress>(_mapSaveHomeAssistantAddressEventToState);
  }

  void _mapLoadHomeAssistantAddressEventToState(
      LoadHomeAssistantAddress event, Emitter<HomeAssistantAddressState> emit) async {
    try {
      final homeAssistantAddress = await settingsRepository.getHomeAssistantAddress();
      emit(HomeAssistantAddressLoaded(homeAssistantAddress));
    } catch (e) {
      emit(HomeAssistantAddressLoaded(''));
      ToastUtils.showErrorToast('Error loading Home Assistant address');
    }
  }


  void _mapEditHomeAssistantAddressEventToState(
      EditHomeAssistantAddress event, Emitter<HomeAssistantAddressState> emit) async {
    emit(HomeAssistantAddressEditing(event.homeAssistantAddress));
  }

  void _mapSaveHomeAssistantAddressEventToState(
      SaveHomeAssistantAddress event, Emitter<HomeAssistantAddressState> emit) async {
    try {
      await settingsRepository.saveHomeAssistantAddress(event.homeAssistantAddress);
      emit(HomeAssistantAddressLoaded(event.homeAssistantAddress));
      ToastUtils.showSuccessToast('Home Assistant address updated');
    } catch (e) {
      ToastUtils.showErrorToast('Error updating Home Assistant address');
    }

  }


}
