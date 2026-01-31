import '../../../core/base/model/base.dart';
import 'chat_message.dart';
import 'chat_pagination.dart';

class ChatMessagesModel extends BaseModel<ChatMessagesModel> {
  String? conversationId;
  List<ChatMessageModel>? messages;
  ChatPaginationModel? pagination;

  ChatMessagesModel({
    this.conversationId,
    this.messages,
    this.pagination,
  });

  @override
  ChatMessagesModel copyWith({
    String? conversationId,
    List<ChatMessageModel>? messages,
    ChatPaginationModel? pagination,
  }) {
    return ChatMessagesModel(
      conversationId: conversationId ?? this.conversationId,
      messages: messages ?? this.messages,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  ChatMessagesModel fromJson(Map<String, dynamic> json) {
    return ChatMessagesModel(
      conversationId: json['conversation_id'] as String?,
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((e) => ChatMessageModel().fromJson(e))
              .toList()
          : null,
      pagination: json['pagination'] != null
          ? ChatPaginationModel().fromJson(json['pagination'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conversationId,
      'messages': messages?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}
