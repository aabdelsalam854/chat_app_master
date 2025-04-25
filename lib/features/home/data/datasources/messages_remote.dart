import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';

abstract class MessagesRemoteDataSource {
  Future<List<UserModel>> getUsers();

  Stream<List<Conversation>> getAllConversations();

  Stream<List<Conversation>> getAllGroupConversations();
}

class MessageRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final DatabaseServices firestore;
  MessageRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<UserModel>> getUsers() async {
    final users = await firestore.getAllDocuments(EndPoint.userCollection);
    return users.map((e) {
      return UserModel.fromJson(e);
    }).toList();
  }

  @override
  Stream<List<Conversation>> getAllConversations() {
    return firestore
        .getCollectionStream(collectionPath: EndPoint.kChatCollection)
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Conversation.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<List<Conversation>> getAllGroupConversations() {
    return firestore
        .getCollectionStream(collectionPath: EndPoint.kGroupCollection)
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Conversation.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
