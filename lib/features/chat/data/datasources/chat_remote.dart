import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/features/chat/data/model/chat_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage(ChatModel chatModel);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final DatabaseServices _databaseServices;

  ChatRemoteDataSourceImpl(this._databaseServices);
  @override
  String generateChatId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    return sortedIds.join("_");
  }

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    // String chatId = generateChatId(userId1, userId2);
    return _databaseServices
        .getCollectionStream(
            collectionPath: EndPoint.kChatCollection,
            docId: chatId,
            subCollectionPath: EndPoint.kMessageCollection,
            orderByField: "time",
            descending: true,
            limit: 20)
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return MessageModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });

    // return _firestore
    //     .collection('chats')
    //     .doc(chatId)
    //     .collection('messages')
    //     .orderBy('time', descending: true)
    //     .limit(20)
    //     .snapshots()
    //     .map((querySnapshot) {
    //   return querySnapshot.docs.map((doc) {
    //     return MessageModel.fromJson(doc.data());
    //   }).toList();
    // });
  }

  @override
  Future<void> sendMessage(ChatModel chatModel) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
