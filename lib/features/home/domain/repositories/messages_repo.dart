import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';

import 'package:dartz/dartz.dart';
import 'package:chat_master/core/model/user_model.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();
  // Future<dynamic> sendMessage(String userId, String chatId, String message);
  // Future<dynamic> deleteMessage(String userId, String chatId, String messageId);
  // Future<dynamic> updateMessage(String userId, String chatId, String messageId, String newMessage);
  // Future<dynamic> getMessageById(String userId, String chatId, String messageId);
  Stream<Either<Failure, List<Conversation>>> getAllConversations();
  Stream<Either<Failure, List<Conversation>>> getAllGroupConversations();
}
