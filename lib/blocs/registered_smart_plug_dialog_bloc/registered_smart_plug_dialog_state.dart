import 'package:smart_plug_data/data/database/database.dart';

abstract class RegisteredSmartPlugDialogState {}

class RegisteredSmartPlugDialogOpen extends RegisteredSmartPlugDialogState {
  final RegisteredSmartPlug registeredSmartPlug;

  RegisteredSmartPlugDialogOpen(this.registeredSmartPlug);
}

class RegisteredSmartPlugDialogClosed extends RegisteredSmartPlugDialogState {}


class RegisteredSmartPlugUpdated extends RegisteredSmartPlugDialogState {
}

class RegisteredSmartPlugDeleted extends RegisteredSmartPlugDialogState {
}

