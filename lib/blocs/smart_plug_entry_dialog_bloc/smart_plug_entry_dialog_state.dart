import 'package:smart_plug_data/data/database/database.dart';

abstract class SmartPlugEntryDialogState {}

class SmartPlugEntryDialogOpen extends SmartPlugEntryDialogState {
  final SmartPlugEntry smartPlugEntry;

  SmartPlugEntryDialogOpen(this.smartPlugEntry);
}

class SmartPlugEntryDialogClosed extends SmartPlugEntryDialogState {}

class SmartPlugEntryUpdated extends SmartPlugEntryDialogState {}

class SmartPlugEntryDeleted extends SmartPlugEntryDialogState {}
