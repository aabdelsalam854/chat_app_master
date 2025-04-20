import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/domain/repositories/chat_repo.dart';
import 'package:dartz/dartz.dart';

class ChatUsecases {
  final ChatRepository chatRepository;

  ChatUsecases(this.chatRepository);

  Stream<Either<Failure, List<MessageModel>>> getMessages(
          {required String userId1, required String userId2}) =>
      chatRepository.getMessages(userId1: userId1, userId2: userId2);
}
