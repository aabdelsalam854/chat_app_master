import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/home/domain/repositories/messages_repo.dart';
import 'package:dartz/dartz.dart';

class MessagesUsecases {
  final MessageRepository messagesRepo;
  MessagesUsecases(this.messagesRepo);
  Future<Either<Failure, dynamic>> getUserMessages(String userId) =>
      messagesRepo.getUserMessages(userId);
  // Future<dynamic> sendMessage(String userId, String chatId, String message) => messagesRepo.sendMessage(userId, chatId, message);
}
