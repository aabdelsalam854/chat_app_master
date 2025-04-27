import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/home/domain/entities/participants_entity.dart';

class Participants extends ParticipantsEntity {
  const Participants({required super.sender, required super.receiver});

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']));
}
