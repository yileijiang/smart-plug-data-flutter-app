import 'package:smart_plug_data/data/database/database.dart';

abstract class RegisteredSmartPlugDialogEvent {}

class OpenRegisteredSmartPlugDialog extends RegisteredSmartPlugDialogEvent {
  final RegisteredSmartPlug registeredSmartPlug;

  OpenRegisteredSmartPlugDialog(this.registeredSmartPlug);
}

class UpdateRegisteredSmartPlug extends RegisteredSmartPlugDialogEvent {
  final RegisteredSmartPlug registeredSmartPlug;
  final String homeAssistantEntityId;
  final String deviceClassAttribute;
  final bool getNotificationsBoolean;

  UpdateRegisteredSmartPlug(this.registeredSmartPlug, this.homeAssistantEntityId, this.deviceClassAttribute, this.getNotificationsBoolean);
}

class DeleteRegisteredSmartPlug extends RegisteredSmartPlugDialogEvent {
  final RegisteredSmartPlug registeredSmartPlug;

  DeleteRegisteredSmartPlug(this.registeredSmartPlug);
}

