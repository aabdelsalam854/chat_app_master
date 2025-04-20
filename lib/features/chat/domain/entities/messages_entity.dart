import 'package:chat_master/features/chat/data/model/metadata_model.dart';
import 'package:equatable/equatable.dart';

class MessagesEntity extends Equatable {
  final String message;
  final String type;
final String id;
  final DateTime time;
  final MetadataModel? metadata;

  const MessagesEntity(
      {required this.message,
      required this.type,
      required this.time,
      required this.id,
      required this.metadata});

  @override
  List<Object?> get props => [message, type, time, metadata , id];
}
