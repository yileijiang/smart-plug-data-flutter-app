import 'package:smart_plug_data/data/database/database.dart';

abstract class RegisteredSmartPlugDialogEvent {}

class OpenEditRegisteredSmartPlugDialog extends RegisteredSmartPlugDialogEvent {
  final RegisteredSmartPlug registeredSmartPlug;

  OpenEditRegisteredSmartPlugDialog(this.registeredSmartPlug);
}

class OpenNewRegisteredSmartPlugDialog extends RegisteredSmartPlugDialogEvent {}

class CloseRegisteredSmartPlugDialog extends RegisteredSmartPlugDialogEvent {}

class AddNewRegisteredSmartPlug extends RegisteredSmartPlugDialogEvent {
  final String homeAssistantEntityId;
  final String deviceClassAttribute;
  final bool getNotificationsBoolean;

  AddNewRegisteredSmartPlug(this.homeAssistantEntityId,
      this.deviceClassAttribute, this.getNotificationsBoolean);
}

class UpdateRegisteredSmartPlug extends RegisteredSmartPlugDialogEvent {
  final RegisteredSmartPlug registeredSmartPlug;
  final String homeAssistantEntityId;
  final String deviceClassAttribute;
  final bool getNotificationsBoolean;

  UpdateRegisteredSmartPlug(
      this.registeredSmartPlug,
      this.homeAssistantEntityId,
      this.deviceClassAttribute,
      this.getNotificationsBoolean);
}

class DeleteRegisteredSmartPlug extends RegisteredSmartPlugDialogEvent {
  final RegisteredSmartPlug registeredSmartPlug;

  DeleteRegisteredSmartPlug(this.registeredSmartPlug);
}
