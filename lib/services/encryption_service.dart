import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';

class EncryptionService {
  AesCrypt crypt = AesCrypt();

  String encryptDataAndSaveToFile(
      String data, String path, String filename, String encryptionPassword) {
    crypt.setOverwriteMode(AesCryptOwMode.rename);
    crypt.setPassword(encryptionPassword);
    return crypt.encryptTextToFileSync(data, '$path/$filename.aes');
  }
}
