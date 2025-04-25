import 'dart:io';

import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/data/model/metadata_model.dart';
import 'package:chat_master/features/chat/domain/repositories/chat_repo.dart';
import 'package:dartz/dartz.dart';

class ChatUsecases {
  final ChatRepository _chatRepository;

  ChatUsecases(this._chatRepository);

  Stream<Either<Failure, List<MessageModel>>> getMessages(
          {required String userId1, required String userId2}) =>
      _chatRepository.getMessages(userId1: userId1, userId2: userId2);
  Future<Either<Failure, void>> sendMessage(
      {required String userId1,
      required String userId2,
      required MessageModel message,
      required UserModel user1,
      required UserModel user2}) async {
    return await _chatRepository.sendMessage(
      userId1: userId1,
      userId2: userId2,
      message: message,
      user1: user1,
      user2: user2,
    );
  }

  Future<Either<Failure, void>> sendFiles({
    required List<File> files,
    required String description,
    required UserModel user1,
    required UserModel user2,
    required String userId1,
    required String userId2,
  }) async {
    for (var file in files) {
      final url = await UploadFileInFirebase.uploadFile(file);

      final fileType = getFileType(file.path);

      final message = MessageModel(
        message: url,
        id: user1.id,
        type: fileType,
        time: DateTime.now(),
        metadata: MetadataModel(
          width: 0,
          height: 0,
          details: description,
          fileSize: file.lengthSync().toString(),
          fileType: fileType,
          fileName: file.path.split('/').last,
        ),
      );

      await _chatRepository.sendMessage(
        userId1: userId1,
        userId2: userId2,
        user1: user1,
        user2: user2,
        message: message,
      );
    }

    return const Right(true);
  }
}
