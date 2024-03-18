abstract class DataSharingDialogState {}

class DataSharingDialogOpen extends DataSharingDialogState {}

class DataSharingDialogClosed extends DataSharingDialogState {}

class DataDownloadSuccess extends DataSharingDialogState {
  String path;

  DataDownloadSuccess(this.path);
}
