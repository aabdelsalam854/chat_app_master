import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireCloud {
  static Future<void> sendMessage(MessageModel message) async {
    CollectionReference messages =
        FirebaseFirestore.instance.collection("messages");
    await messages.add(message.toJson());
  }

  static Stream<QuerySnapshot<Object?>> getMessages() {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(EndPoint.kMessageCollection);
    return messages.orderBy('time', descending: true).limit(20).snapshots();
  }
}
// message.orderBy('time', descending: true).snapshots(),
