import 'package:chat_master/core/error/failures.dart';

import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/domain/repositories/messages_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_master/core/model/user_model.dart';

class MessagesUsecases {
  final MessageRepository messagesRepo;
  MessagesUsecases(this.messagesRepo);
  Future<Either<Failure, List<UserModel>>> getUsers(String userId) =>
      messagesRepo.getUsers(userId);
  Stream<Either<Failure, List<Conversation>>> getAllConversations() =>
      messagesRepo.getAllConversations();
}
