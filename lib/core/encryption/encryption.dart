import 'package:encrypt/encrypt.dart';

const String _iv = '1234567890123456';
const String _passKey = 'hrAppKey12345678';

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
