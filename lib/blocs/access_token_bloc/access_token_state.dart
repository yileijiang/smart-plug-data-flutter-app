abstract class AccessTokenState {}

class AccessTokenReadOnly extends AccessTokenState {
}

class AccessTokenEditing extends AccessTokenState {
  String accessToken;

  AccessTokenEditing(this.accessToken);
}

class AccessTokenUpdated extends AccessTokenState {
}