import 'package:chat_master/core/model/user_model.dart';
import 'package:equatable/equatable.dart';

class ParticipantsEntity extends Equatable {
  final UserModel sender;
  final UserModel receiver;

  const ParticipantsEntity({required this.sender, required this.receiver});

  @override
  List<Object?> get props => [sender, receiver];
}
