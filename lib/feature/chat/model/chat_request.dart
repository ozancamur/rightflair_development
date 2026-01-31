import '../../../core/base/model/base.dart';

class ChatRequestModel extends BaseModel<ChatRequestModel> {
  String? conversationId;
  int? page;
  int? limit;
  String? beforeMessageId;

  ChatRequestModel({
    this.conversationId,
    this.page,
    this.limit,
    this.beforeMessageId,
  });

  @override
  ChatRequestModel copyWith({
    String? conversationId,
    int? page,
    int? limit,
    String? beforeMessageId,
  }) {
    return ChatRequestModel(
      conversationId: conversationId ?? this.conversationId,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      beforeMessageId: beforeMessageId ?? this.beforeMessageId,
    );
  }

  @override
  ChatRequestModel fromJson(Map<String, dynamic> json) {
    return ChatRequestModel(
      conversationId: json['conversation_id'] as String?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      beforeMessageId: json['before_message_id'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'conversation_id': conversationId,
      'page': page,
      'limit': limit,
    };
    if (beforeMessageId != null) {
      data['before_message_id'] = beforeMessageId;
    }
    return data;
  }
}
