import 'dart:developer';

import 'package:chat_master/core/constant/endpoint.dart';

import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';

import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRemoteDataSource {
  Stream<List<MessageModel>> getMessages(String chatId);

  Future<void> sendMessage(
    String chatId,
    MessageModel message,
    UserModel user1,
    UserModel user2,
  );
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final DatabaseServices _databaseServices;

  ChatRemoteDataSourceImpl(this._databaseServices);
  @override
  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
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
  }

  @override
  Future<void> sendMessage(String chatId, MessageModel message, UserModel user1,
      UserModel user2) async {
    final chatExists = await _databaseServices.getData(
      path: EndPoint.kChatCollection,
      docId: chatId,
    );

    if (chatExists == null) {
      await _databaseServices.setData(
        path: EndPoint.kChatCollection,
        docId: chatId,
        data: {
          'participants': {
            "sender": user1.toJson(),
            "receiver": user2.toJson(),
          },
          'users': [user1.id, user2.id],
          'createdAt': FieldValue.serverTimestamp(),
        },
      );
    }

    await _databaseServices.addData(
      path: EndPoint.kChatCollection,
      docId: chatId,
      subCollectionPath: EndPoint.kMessageCollection,
      data: message.toJson()
        ..addAll({
          'isRead': false,
          'sentAt': FieldValue.serverTimestamp(),
        }),
    );

    await _databaseServices.updateData(
      path: EndPoint.kChatCollection,
      docId: chatId,
      data: {
        'lastMessage': message.message,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'lastMessageType': message.type,
      },
    );
  }
}
