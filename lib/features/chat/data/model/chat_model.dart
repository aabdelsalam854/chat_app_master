import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String name;
  final String image;
  final String lastMessage;
  final DateTime time;

  ChatModel({
    required this.id,
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.time,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      lastMessage: json['lastMessage'],
      time: (json['time'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'lastMessage': lastMessage,
      'time': Timestamp.fromDate(time),
    };
  }
}
