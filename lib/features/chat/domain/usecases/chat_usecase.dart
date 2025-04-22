import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
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
}
