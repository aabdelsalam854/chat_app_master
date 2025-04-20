import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireCloud {
  static Future<void> sendMessage(MessageModel message) async {
    CollectionReference messages = FirebaseFirestore.instance
        .collection("messages")
        .doc(message.toString())
        .collection(EndPoint.kMessageCollection);
    await messages.add(message.toJson());
  }

  // static String _getConversationId(String currentUserId, String otherUserId) {
  //   List<String> users = [currentUserId, otherUserId];
  //   users.sort();
  //   return users.join('_');
  // }

  static Stream<QuerySnapshot<Object?>> getMessages() {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(EndPoint.kMessageCollection);
    return messages.orderBy('time', descending: true).limit(20).snapshots();
  }
}

// message.orderBy('time', descending: true).snapshots(),
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

  String generateChatId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    return sortedIds.join("_");
  }

  // Stream<List<ConversationModel>> getAllConversations(String currentUserId) {
  //   return _firestore
  //       .collection('chats')
  //       .where('users', arrayContains: currentUserId)
  //       .orderBy('lastMessageTime', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) {
  //             final data = doc.data();
  //             return ConversationModel.fromJson(data);
  //           }).toList());
  // }

  Stream<List<MessageModel>> getMessages(String userId1, String userId2) {
    String chatId = generateChatId(userId1, userId2);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('time', descending: true)
        .limit(20)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return MessageModel.fromJson(doc.data());
      }).toList();
    });
  }
}
