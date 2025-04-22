import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
    String userId1,
    String userId2,
    MessageModel message,
    UserModel user1,
    UserModel user2,
  ) async {
    String chatId = generateChatId(userId1, userId2);

    var chatDoc = await _firestore.collection('chats').doc(chatId).get();

    if (!chatDoc.exists) {
      await _firestore.collection('chats').doc(chatId).set({
        'participants': {
          "sender": user1.toJson(),
          "receiver": user2.toJson(),
        },
        'users': [userId1, userId2],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    final messageData = message.toJson()
      ..addAll({
        'isRead': false,
        'sentAt': FieldValue.serverTimestamp(),
      });

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageData);

    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': message.message,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'lastMessageType': message.type,
    });
  }
}
