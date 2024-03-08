abstract class AccessTokenState {}

class AccessTokenLoading extends AccessTokenState {
}

class AccessTokenLoaded extends AccessTokenState {
  String accessToken;

  AccessTokenLoaded(this.accessToken);
}

class AccessTokenEditing extends AccessTokenState {
  String accessToken;

  AccessTokenEditing(this.accessToken);
}