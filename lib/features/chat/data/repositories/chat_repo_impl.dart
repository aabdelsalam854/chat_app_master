import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/datasources/chat_remote.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/domain/repositories/chat_repo.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _dataSource;

  ChatRepositoryImpl(this._dataSource);

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessages(
      {required String userId1, required String userId2}) async* {
    try {
      final chatId = generateChatId(userId1, userId2);
      final stream = _dataSource.getMessages(chatId);
      yield* stream.map((messages) => Right(messages));
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      {required String userId1,
      required String userId2,
      required MessageModel message,
      required UserModel user1,
      required UserModel user2}) async {
    try {
      final chatId = generateChatId(userId1, userId2);

      await _dataSource.sendMessage(chatId, message, user1, user2);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<MessageModel>>> getGroupMessages(
      {required String groupId}) async* {
    try {
      final stream = _dataSource.getGroupMessages(groupId);
      yield* stream.map((messages) => Right(messages));
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendGroupMessage(
      {required MessageModel message, required String groupId}) async {
    try {
      await _dataSource.sendGroupMessage(groupId, message);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
