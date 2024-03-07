import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_event.dart';
import 'package:smart_plug_data/blocs/access_token_bloc/access_token_state.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';

class AccessTokenBloc
    extends Bloc<AccessTokenEvent, AccessTokenState> {
  final SettingsRepository settingsRepository;

  AccessTokenBloc({required this.settingsRepository})
      : super(AccessTokenReadOnly()) {
    on<EditAccessToken>(_mapEditAccessTokenEventToState);
    on<SaveAccessToken>(_mapSaveAccessTokenEventToState);
  }

  void _mapEditAccessTokenEventToState(
      EditAccessToken event, Emitter<AccessTokenState> emit) async {
    emit(AccessTokenEditing(event.accessToken));
  }

  void _mapSaveAccessTokenEventToState(
      SaveAccessToken event, Emitter<AccessTokenState> emit) async {
    await settingsRepository.saveAccessToken(event.accessToken);
    emit(AccessTokenUpdated());
    emit(AccessTokenReadOnly());
  }


}
