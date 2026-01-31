import '../model/chat_messages.dart';
import '../model/chat_request.dart';

abstract class ChatRepository {
  Future<ChatMessagesModel?> fetchMessages({required ChatRequestModel request});
  Future<bool> sendMessage({
    required String conversationId,
    required String content,
    String? imageUrl,
  });
}
