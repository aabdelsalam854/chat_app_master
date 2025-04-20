import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Stream<Either<Failure,  List<MessageModel>>> getMessages({
    required String userId1,
    required String userId2,
  });
}
