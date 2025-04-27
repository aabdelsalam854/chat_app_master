import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/home/data/datasources/messages_remote.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/data/models/group_conversation.dart';
import 'package:chat_master/features/home/domain/repositories/messages_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_master/core/model/user_model.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagesRemoteDataSource messagesRemote;
  MessageRepositoryImpl(this.messagesRemote);
  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final res = await messagesRemote.getUsers();
      res.removeWhere((element) => element.id == kUid);

      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Conversation>>> getAllConversations() async* {
    try {
      final stream = messagesRemote.getAllConversations();
      yield* stream.map((event) {
        final filtered =
            event.where((element) => element.userIds.contains(kUid)).toList();

        return Right(filtered);
      });
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<GroupConversation>>>
      getAllGroupConversations() async* {
    try {
      final stream = messagesRemote.getAllGroupConversations();
      yield* stream.map((event) {
        final filtered =
            event.where((element) => element.userIds.contains(kUid)).toList();

        return Right(filtered);
      });
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createGroup(
      {required GroupConversation groupConversation}) async {
    try {
      await messagesRemote.createGroup(groupConversation: groupConversation);
      // ignore: void_checks
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
