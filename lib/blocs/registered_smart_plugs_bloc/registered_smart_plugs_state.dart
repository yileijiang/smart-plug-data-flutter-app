import 'package:smart_plug_data/data/database/database.dart';

abstract class RegisteredSmartPlugsState {}

class RegisteredSmartPlugsLoading extends RegisteredSmartPlugsState {}

class RegisteredSmartPlugsLoaded extends RegisteredSmartPlugsState {
  final List<RegisteredSmartPlug> registeredSmartPlugs;

  RegisteredSmartPlugsLoaded(this.registeredSmartPlugs);
}

class RegisteredSmartPlugsEmpty extends RegisteredSmartPlugsState {
}

class RegisteredSmartPlugsError extends RegisteredSmartPlugsState {
  final String errorMessage;

  RegisteredSmartPlugsError(this.errorMessage);
}