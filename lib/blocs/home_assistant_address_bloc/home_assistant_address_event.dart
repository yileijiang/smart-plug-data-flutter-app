abstract class HomeAssistantAddressEvent {}

class LoadHomeAssistantAddress extends HomeAssistantAddressEvent {
}

class EditHomeAssistantAddress extends HomeAssistantAddressEvent {
  String homeAssistantAddress;

  EditHomeAssistantAddress(this.homeAssistantAddress);
}

class SaveHomeAssistantAddress extends HomeAssistantAddressEvent {
  String homeAssistantAddress;

  SaveHomeAssistantAddress(this.homeAssistantAddress);
}

