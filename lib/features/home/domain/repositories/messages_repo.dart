import 'package:chat_master/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Future<Either<Failure, dynamic>>  getUserMessages(String userId);
  // Future<dynamic> sendMessage(String userId, String chatId, String message);
  // Future<dynamic> deleteMessage(String userId, String chatId, String messageId);
  // Future<dynamic> updateMessage(String userId, String chatId, String messageId, String newMessage);
  // Future<dynamic> getMessageById(String userId, String chatId, String messageId);
  // Future<dynamic> getAllMessages(String userId, String chatId);
}