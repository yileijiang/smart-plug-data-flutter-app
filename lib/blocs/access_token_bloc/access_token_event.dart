abstract class AccessTokenEvent {}

class LoadAccessToken extends AccessTokenEvent {}

class EditAccessToken extends AccessTokenEvent {
  String accessToken;

  EditAccessToken(this.accessToken);
}

class SaveAccessToken extends AccessTokenEvent {
  String accessToken;

  SaveAccessToken(this.accessToken);
}
