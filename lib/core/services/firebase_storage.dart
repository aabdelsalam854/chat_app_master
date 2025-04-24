import 'dart:io';

import 'package:chat_master/core/enums/media_type.dart';
import 'package:chat_master/core/functions/functions.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageService {
  Future<String> uploadFile(String filePath, String fileName,
      {required MediaType type});

  Future<void> deleteFile(String fileName, {required MediaType type});
}

class FirebaseStorageServiceImpl implements FirebaseStorageService {
  final ref = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadFile(String filePath, String fileName,
      {required MediaType type}) async {
    final path = '${getFolderName(type)}/$fileName';
    final fileRef = ref.child(path);

    await fileRef.putFile(File(filePath));

    return await fileRef.getDownloadURL();
  }

  @override
  Future<void> deleteFile(String fileName, {required MediaType type}) async {
    final path = '${getFolderName(type)}/$fileName';
    await ref.child(path).delete();
  }
}
