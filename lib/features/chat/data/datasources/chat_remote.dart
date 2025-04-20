import 'package:chat_master/features/chat/data/model/chat_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatModel>> getChats();
  Future<void> sendMessage(ChatModel chatModel);
  
}
