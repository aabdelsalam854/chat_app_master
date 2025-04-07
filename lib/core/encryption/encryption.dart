import 'package:encrypt/encrypt.dart';

const String _iv = 'hrApp1**@@';
const String _passKey = '@@1**hrApp';

extension EncryptionToString on String {
  String? decrypt() {
    try {
      final iv = IV.fromUtf8(_iv);
      final key = Key.fromUtf8(_passKey);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encryptedData = Encrypted.from64(this);
      return encrypter.decrypt(encryptedData, iv: iv);
    } catch (e) {
      return null;
    }
  }

  String encrypt() {
    final iv = IV.fromUtf8(_iv);
    final key = Key.fromUtf8(_passKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    Encrypted encryptedData = encrypter.encrypt(this, iv: iv);
    return encryptedData.base64;
  }
}
