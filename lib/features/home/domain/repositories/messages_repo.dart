import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/data/models/group_conversation.dart';

import 'package:dartz/dartz.dart';
import 'package:chat_master/core/model/user_model.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();

  Stream<Either<Failure, List<Conversation>>> getAllConversations();
  Stream<Either<Failure, List<GroupConversation>>> getAllGroupConversations();
  Future<Either<Failure, void>> createGroup({
    required GroupConversation groupConversation,
  });
}
