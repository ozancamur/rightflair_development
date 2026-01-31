import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/endpoint.dart';
import 'package:rightflair/core/services/api.dart';
import 'package:rightflair/feature/chat/model/chat_messages.dart';
import 'package:rightflair/feature/chat/model/chat_request.dart';
import 'package:rightflair/core/base/model/response.dart';
import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ApiService _api;
  ChatRepositoryImpl({ApiService? api}) : _api = api ?? ApiService();

  @override
  Future<ChatMessagesModel?> fetchMessages({
    required ChatRequestModel request,
  }) async {
    try {
      final response = await _api.post(
        Endpoint.GET_CONVERSATION_MESSAGES,
        data: request.toJson(),
      );
      final result = ResponseModel().fromJson(
        response?.data as Map<String, dynamic>,
      );
      final messages = ChatMessagesModel().fromJson(
        result.data as Map<String, dynamic>,
      );
      return messages;
    } catch (e) {
      debugPrint("ChatRepositoryImpl ERROR in fetchMessages: $e");
      return null;
    }
  }

  @override
  Future<bool> sendMessage({
    required String conversationId,
    required String content,
    String? imageUrl,
  }) async {
    try {
      final response = await _api.post(
        Endpoint.SEND_MESSAGE,
        data: {
          'conversation_id': conversationId,
          'content': content,
          if (imageUrl != null) 'image_url': imageUrl,
        },
      );
      final result = ResponseModel().fromJson(
        response?.data as Map<String, dynamic>,
      );
      return result.success ?? false;
    } catch (e) {
      debugPrint("ChatRepositoryImpl ERROR in sendMessage: $e");
      return false;
    }
  }
}
