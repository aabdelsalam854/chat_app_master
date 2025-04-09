import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';



abstract class MessagesRemoteDataSource {
  Future<dynamic> getUserMessages(
    String userId,
  );
  
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
  Future<List<UserModel>> getUserMessages(
    String userId,
  ) async {
    final users = await firestore.getAllDocuments(
         EndPoint.userCollection);
    return users.map((e) {
      return UserModel.fromJson(e);
    }).toList();
  }
}
