import '../../../core/base/model/base.dart';

class ChatPaginationModel extends BaseModel<ChatPaginationModel> {
  int? page;
  int? limit;
  int? totalCount;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;
  String? oldestMessageId;
  String? newestMessageId;

  ChatPaginationModel({
    this.page,
    this.limit,
    this.totalCount,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
    this.oldestMessageId,
    this.newestMessageId,
  });

  @override
  ChatPaginationModel copyWith({
    int? page,
    int? limit,
    int? totalCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
    String? oldestMessageId,
    String? newestMessageId,
  }) {
    return ChatPaginationModel(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
      hasNext: hasNext ?? this.hasNext,
      hasPrevious: hasPrevious ?? this.hasPrevious,
      oldestMessageId: oldestMessageId ?? this.oldestMessageId,
      newestMessageId: newestMessageId ?? this.newestMessageId,
    );
  }

  @override
  ChatPaginationModel fromJson(Map<String, dynamic> json) {
    return ChatPaginationModel(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalCount: json['total_count'] as int?,
      totalPages: json['total_pages'] as int?,
      hasNext: json['has_next'] as bool?,
      hasPrevious: json['has_previous'] as bool?,
      oldestMessageId: json['oldest_message_id'] as String?,
      newestMessageId: json['newest_message_id'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total_count': totalCount,
      'total_pages': totalPages,
      'has_next': hasNext,
      'has_previous': hasPrevious,
      'oldest_message_id': oldestMessageId,
      'newest_message_id': newestMessageId,
    };
  }
}
