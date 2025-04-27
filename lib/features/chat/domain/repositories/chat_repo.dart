import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Stream<Either<Failure, List<MessageModel>>> getMessages({
    required String userId1,
    required String userId2,
  });
  Stream<Either<Failure, List<MessageModel>>> getGroupMessages({
    required String groupId,
  });
  Future<Either<Failure, void>> sendMessage(
      {required String userId1,
      required String userId2,
      required MessageModel message,
      required UserModel user1,
      required UserModel user2});


  Future<Either<Failure, void>> sendGroupMessage(
      {
      required MessageModel message,
      required String groupId,
    
   });


}
