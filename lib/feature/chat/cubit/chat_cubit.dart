import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/feature/chat/model/chat_message.dart';
import 'package:rightflair/feature/chat/model/chat_pagination.dart';
import 'package:rightflair/feature/chat/model/chat_request.dart';
import 'package:rightflair/feature/chat/repository/chat_repository_impl.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepositoryImpl _repo;
  final String conversationId;
  final String otherUserName;
  final String? otherUserPhoto;
  final String otherUserId;

  ChatCubit({
    required this.conversationId,
    required this.otherUserName,
    this.otherUserPhoto,
    required this.otherUserId,
    ChatRepositoryImpl? repo,
  }) : _repo = repo ?? ChatRepositoryImpl(),
       super(ChatState.initial()) {
    _loadMessages();
  }

  Future<void> _loadMessages({int page = 1}) async {
    emit(state.copyWith(isLoading: true));

    final request = ChatRequestModel(
      conversationId: conversationId,
      page: page,
      limit: 50,
    );

    final response = await _repo.fetchMessages(request: request);

    if (response != null) {
      emit(
        state.copyWith(
          isLoading: false,
          messages: response.messages ?? [],
          pagination: response.pagination,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false, error: 'Failed to load messages'));
    }
  }

  Future<void> loadMoreMessages() async {
    if (state.isLoadingMore || state.pagination?.hasNext != true) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = (state.pagination?.page ?? 0) + 1;
    final request = ChatRequestModel(
      conversationId: conversationId,
      page: nextPage,
      limit: 50,
      beforeMessageId: state.pagination?.oldestMessageId,
    );

    final response = await _repo.fetchMessages(request: request);

    if (response != null) {
      final updatedMessages = [...state.messages, ...?response.messages];
      emit(
        state.copyWith(
          isLoadingMore: false,
          messages: updatedMessages,
          pagination: response.pagination,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> sendMessage(String content, {String? imageUrl}) async {
    if (content.trim().isEmpty && imageUrl == null) return;

    emit(state.copyWith(isSending: true));

    final success = await _repo.sendMessage(
      conversationId: conversationId,
      content: content,
      imageUrl: imageUrl,
    );

    if (success) {
      // Reload messages to get the new message from server
      await _loadMessages();
      emit(state.copyWith(isSending: false));
    } else {
      emit(state.copyWith(isSending: false, error: 'Failed to send message'));
    }
  }

  Future<void> refresh() async {
    await _loadMessages();
  }
}
