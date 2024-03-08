import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_event.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class AccessTokenBloc extends Bloc<AccessTokenEvent, AccessTokenState> {
  final SettingsRepository settingsRepository;

  AccessTokenBloc({required this.settingsRepository})
      : super(AccessTokenLoading()) {
    on<LoadAccessToken>(_mapLoadAccessTokenEventToState);
    on<EditAccessToken>(_mapEditAccessTokenEventToState);
    on<SaveAccessToken>(_mapSaveAccessTokenEventToState);
  }

  void _mapLoadAccessTokenEventToState(
      LoadAccessToken event, Emitter<AccessTokenState> emit) async {
    try {
      final accessToken = await settingsRepository.getAccessToken();
      emit(AccessTokenLoaded(accessToken));
    } catch (e) {
      emit(AccessTokenLoaded(''));
      ToastUtils.showErrorToast('Error loading access token');
    }
  }

  void _mapEditAccessTokenEventToState(
      EditAccessToken event, Emitter<AccessTokenState> emit) async {
    emit(AccessTokenEditing(event.accessToken));
  }

  void _mapSaveAccessTokenEventToState(
      SaveAccessToken event, Emitter<AccessTokenState> emit) async {
    try {
      await settingsRepository.saveAccessToken(event.accessToken);
      emit(AccessTokenLoaded(event.accessToken));
      ToastUtils.showSuccessToast('Access token updated');
    } catch (e) {
      ToastUtils.showErrorToast('Error updating access token');
    }
  }
}
