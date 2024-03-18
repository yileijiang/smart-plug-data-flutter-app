import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_event.dart';
import 'package:smart_plug_data/blocs/smart_plug_entries_bloc/smart_plug_entries_state.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries _repository.dart';

class SmartPlugEntriesBloc
    extends Bloc<SmartPlugEntriesEvent, SmartPlugEntriesState> {
  final SmartPlugEntriesRepository smartPlugEntriesRepository;

  SmartPlugEntriesBloc({required this.smartPlugEntriesRepository})
      : super(SmartPlugEntriesLoading()) {
    on<FetchSmartPlugEntries>(_mapFetchSmartPlugEntriesEventToState);
  }

  void _mapFetchSmartPlugEntriesEventToState(
      FetchSmartPlugEntries event, Emitter<SmartPlugEntriesState> emit) async {
    try {
      final smartPlugEntries =
          await smartPlugEntriesRepository.getSmartPlugEntries();
      if (smartPlugEntries.isEmpty) {
        emit(SmartPlugEntriesEmpty());
      } else {
        emit(SmartPlugEntriesLoaded(smartPlugEntries));
      }
    } catch (e) {
      emit(SmartPlugEntriesError('Failed to fetch smart plug entries: $e'));
    }
  }
}
