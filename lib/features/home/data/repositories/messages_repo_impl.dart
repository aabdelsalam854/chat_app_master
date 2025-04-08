import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/home/data/datasources/messages_remote.dart';
import 'package:chat_master/features/home/domain/repositories/messages_repo.dart';
import 'package:dartz/dartz.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessagesRemoteDataSource messagesRemote;
  MessageRepositoryImpl(this.messagesRemote);
  @override
  Future<Either<Failure, dynamic>> getUserMessages(String userId) async {
    try {
      final res = await messagesRemote.getUserMessages(userId);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
