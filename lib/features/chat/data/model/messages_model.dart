import 'package:chat_master/features/chat/domain/entities/messages_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'metadata_model.dart';

class MessageModel extends MessagesEntity {
  const MessageModel(
      {required super.message,
      required super.type,
      required super.time,
      required super.id,
      required super.metadata});

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      message: jsonData["message"],
      type: jsonData['type'],
      id: jsonData['id'],
      time: (jsonData['time'] as Timestamp).toDate(),
      metadata: jsonData['metadata'] != null
          ? MetadataModel.fromJson(jsonData['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "type": type,
        "id": id,
        "time": time,
        "metadata": metadata?.toJson(),
      };
}
