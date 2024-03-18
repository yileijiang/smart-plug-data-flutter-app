import 'package:smart_plug_data/data/database/database.dart';

abstract class SmartPlugEntriesState {}

class SmartPlugEntriesLoading extends SmartPlugEntriesState {}

class SmartPlugEntriesLoaded extends SmartPlugEntriesState {
  final List<SmartPlugEntry> entries;

  SmartPlugEntriesLoaded(this.entries);
}

class SmartPlugEntriesEmpty extends SmartPlugEntriesState {}

class SmartPlugEntriesError extends SmartPlugEntriesState {
  final String errorMessage;

  SmartPlugEntriesError(this.errorMessage);
}
