import 'package:chat_master/core/error/failures.dart';

import 'package:chat_master/features/home/data/datasources/messages_remote.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/domain/repositories/messages_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_master/core/model/user_model.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagesRemoteDataSource messagesRemote;
  MessageRepositoryImpl(this.messagesRemote);
  @override
  Future<Either<Failure, List<UserModel>>> getUsers(String userId) async {
    try {
      final res = await messagesRemote.getUsers(userId);
      res.removeWhere((element) => element.id == userId);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Conversation>>> getAllConversations() async {
    try {
      final res = await messagesRemote.getAllConversations();
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
