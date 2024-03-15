abstract class DataSharingDialogEvent {}


class OpenDataSharingDialog extends DataSharingDialogEvent {}

class CloseDataSharingDialog extends DataSharingDialogEvent {}

class DownloadData extends DataSharingDialogEvent {
  String fileName;
  String encryptionPassword;

  DownloadData(this.fileName, this.encryptionPassword);
}

class ShareData extends DataSharingDialogEvent {
  String path;

  ShareData(this.path);
}