import 'package:smart_plug_data/data/database/database.dart';

abstract class SmartPlugEntryDialogEvent {}

class OpenSmartPlugEntryDialog extends SmartPlugEntryDialogEvent {
  final SmartPlugEntry smartPlugEntry;

  OpenSmartPlugEntryDialog(this.smartPlugEntry);
}

class CloseSmartPlugEntryDialog extends SmartPlugEntryDialogEvent {
}

class UpdateSmartPlugEntry extends SmartPlugEntryDialogEvent {
  final SmartPlugEntry smartPlugEntry;
  final String newLabel;

  UpdateSmartPlugEntry(this.smartPlugEntry, this.newLabel);
}

class DeleteSmartPlugEntry extends SmartPlugEntryDialogEvent {
  final SmartPlugEntry smartPlugEntry;

  DeleteSmartPlugEntry(this.smartPlugEntry);
}

