import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';

abstract class MessagesRemoteDataSource {
  Future<List<UserModel>> getUsers(
    String userId,
  );

  Future<List<Conversation>> getAllConversations();

// Future<dynamic> sendMessage(String userId, String chatId, String message);
// Future<dynamic> deleteMessage(String userId, String chatId, String messageId);
// Future<dynamic> updateMessage(String userId, String chatId, String messageId, String newMessage);
// Future<dynamic> getMessageById(String userId, String chatId, String messageId);
// Future<dynamic> getAllMessages(String userId, String chatId);
}

class MessageRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final DatabaseServices firestore;
  MessageRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<UserModel>> getUsers(
    String userId,
  ) async {
    final users = await firestore.getAllDocuments(EndPoint.userCollection);
    return users.map((e) {
      return UserModel.fromJson(e);
    }).toList();
  }

  @override
  Future<List<Conversation>> getAllConversations() async {
    final conversation =
        await firestore.getAllDocuments("chats");
    return conversation.map((e) => Conversation.fromJson(e)).toList();
  }
}
