import 'package:smart_plug_data/data/database/database.dart';

abstract class RegisteredSmartPlugDialogState {}

class EditRegisteredSmartPlugDialogOpen extends RegisteredSmartPlugDialogState {
  final RegisteredSmartPlug registeredSmartPlug;

  EditRegisteredSmartPlugDialogOpen(this.registeredSmartPlug);
}

class NewRegisteredSmartPlugDialogOpen extends RegisteredSmartPlugDialogState {
}

class RegisteredSmartPlugDialogClosed extends RegisteredSmartPlugDialogState {}

class NewRegisteredSmartPlugAdded extends RegisteredSmartPlugDialogState {
}

class RegisteredSmartPlugUpdated extends RegisteredSmartPlugDialogState {
}

class RegisteredSmartPlugDeleted extends RegisteredSmartPlugDialogState {
}

