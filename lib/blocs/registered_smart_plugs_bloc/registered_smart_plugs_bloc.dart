import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_event.dart';
import 'package:smart_plug_data/blocs/registered_smart_plugs_bloc/registered_smart_plugs_state.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';

class RegisteredSmartPlugsBloc
    extends Bloc<RegisteredSmartPlugsEvent, RegisteredSmartPlugsState> {
  final RegisteredSmartPlugsRepository registeredSmartPlugsRepository;

  RegisteredSmartPlugsBloc({required this.registeredSmartPlugsRepository})
      : super(RegisteredSmartPlugsLoading()) {
    on<FetchRegisteredSmartPlugs>(_mapRegisteredSmartPlugsEventToState);
  }

  void _mapRegisteredSmartPlugsEventToState(FetchRegisteredSmartPlugs event,
      Emitter<RegisteredSmartPlugsState> emit) async {
    emit(RegisteredSmartPlugsLoading());

    try {
      final registeredSmartPlugs =
          await registeredSmartPlugsRepository.getRegisteredSmartPlugs();
      if (registeredSmartPlugs.isEmpty) {
        emit(RegisteredSmartPlugsEmpty());
      } else {
        emit(RegisteredSmartPlugsLoaded(registeredSmartPlugs));
      }
    } catch (e) {
      emit(RegisteredSmartPlugsError(
          'Failed to fetch registered smart plugs: $e'));
    }
  }
}
