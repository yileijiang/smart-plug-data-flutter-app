import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_event.dart';
import 'package:smart_plug_data/blocs/data_sharing_dialog_bloc/data_sharing_dialog_state.dart';
import 'package:smart_plug_data/data/database/database.dart';
import 'package:smart_plug_data/data/repositories/smart_plug_entries _repository.dart';
import 'package:smart_plug_data/services/encryption_service.dart';
import 'package:smart_plug_data/utils/anonymization_utils.dart';
import 'package:smart_plug_data/utils/toast_utils.dart';

class DataSharingDialogBloc
    extends Bloc<DataSharingDialogEvent, DataSharingDialogState> {
  final SmartPlugEntriesRepository smartPlugEntriesRepository;

  DataSharingDialogBloc({required this.smartPlugEntriesRepository})
      : super(DataSharingDialogClosed()) {
    on<OpenDataSharingDialog>(_mapOpenDataSharingDialogEventToState);
    on<CloseDataSharingDialog>(_mapCloseDataSharingDialogEventToState);
    on<DownloadData>(_mapDownloadDataEventToState);
    on<ShareData>(_mapShareDataEventToState);
  }

  void _mapOpenDataSharingDialogEventToState(
      OpenDataSharingDialog event, Emitter<DataSharingDialogState> emit) async {
    emit(DataSharingDialogOpen());
  }

  void _mapCloseDataSharingDialogEventToState(CloseDataSharingDialog event,
      Emitter<DataSharingDialogState> emit) async {
    emit(DataSharingDialogClosed());
  }

  void _mapDownloadDataEventToState(
      DownloadData event, Emitter<DataSharingDialogState> emit) async {
    if (event.fileName.isEmpty) {
      ToastUtils.showErrorToast('Please provide a file name');
      return;
    }

    if (event.encryptionPassword.isEmpty) {
      ToastUtils.showErrorToast('Please provide an encryption password');
      return;
    }

    try {
      Directory? fileDirectory = Directory('/storage/emulated/0/Download');
      if (!await fileDirectory.exists()) {
        ToastUtils.showErrorToast('Error: download directory does not exist');
        return;
      }

      List<SmartPlugEntry> smartPlugEntries =
          await smartPlugEntriesRepository.getSmartPlugEntries();
      List<SmartPlugEntry> anonymizedSmartPlugEntries =
          AnonymizationUtils.anonymizeHomeAssistantEntityIds(smartPlugEntries);

      String smartPlugEntriesJson =
          jsonEncode(anonymizedSmartPlugEntries, toEncodable: (value) {
        if (value is SmartPlugEntry) {
          return <String, dynamic>{
            'entryId': value.entryId.toString(),
            'homeAssistantEntityId': value.homeAssistantEntityId.toString(),
            'timeStamp': value.timeStamp.toIso8601String(),
            'state': value.state.toString(),
            'deviceClass': value.deviceClass.toString(),
            'label': value.label.toString(),
          };
        }
      });

      String path = GetIt.instance<EncryptionService>()
          .encryptDataAndSaveToFile(smartPlugEntriesJson, fileDirectory.path,
              event.fileName, event.encryptionPassword);

      emit(DataDownloadSuccess(path));

      ToastUtils.showSuccessToast('Downloaded data at $path');
    } catch (e) {
      ToastUtils.showErrorToast('Error downloading data');
    }
  }

  void _mapShareDataEventToState(
      ShareData event, Emitter<DataSharingDialogState> emit) async {
    try {
      final result = await Share.shareXFiles([XFile(event.path)],
          text:
              'Attachment contains AES encrypted smart plug data entries in JSON format. The file can be decrypted with the password and any software using the AES Crypt standard file format. More information on AES Crypt can be found at https://www.aescrypt.com/',
          subject: 'Smart Plug Data Entries');

      if (result.status == ShareResultStatus.success) {
        ToastUtils.showSuccessToast('File shared');
      }
    } catch (e) {
      ToastUtils.showErrorToast('Error sharing file');
    }
  }
}
