abstract class HomeAssistantAddressState {}

class HomeAssistantAddressLoading extends HomeAssistantAddressState {}

class HomeAssistantAddressLoaded extends HomeAssistantAddressState {
  String homeAssistantAddress;

  HomeAssistantAddressLoaded(this.homeAssistantAddress);
}

class HomeAssistantAddressEditing extends HomeAssistantAddressState {
  String homeAssistantAddress;

  HomeAssistantAddressEditing(this.homeAssistantAddress);
}
