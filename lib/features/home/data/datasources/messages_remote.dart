import 'dart:developer';

import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/data/models/group_conversation.dart';

abstract class MessagesRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Stream<List<Conversation>> getAllConversations();
  Stream<List<GroupConversation>> getAllGroupConversations();
  Future<void> createGroup({
    required GroupConversation groupConversation,
  });
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
  Stream<List<GroupConversation>> getAllGroupConversations() {
    return firestore
        .getCollectionStream(collectionPath: EndPoint.kGroupCollection)
        .map((snapshot) {
      log(snapshot.docs.toString());

      return snapshot.docs
          .map((doc) => GroupConversation.fromJson(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  @override
  Future<void> createGroup(
      {required GroupConversation groupConversation}) async {
    return firestore.addData(
        path: EndPoint.kGroupCollection, data: groupConversation.toJson());
  }
}
