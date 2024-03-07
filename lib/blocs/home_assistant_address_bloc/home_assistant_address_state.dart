abstract class HomeAssistantAddressState {}

class HomeAssistantAddressReadOnly extends HomeAssistantAddressState {
}

class HomeAssistantAddressEditing extends HomeAssistantAddressState {
  String homeAssistantAddress;

  HomeAssistantAddressEditing(this.homeAssistantAddress);
}

class HomeAssistantAddressUpdated extends HomeAssistantAddressState {
}