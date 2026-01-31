import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/base/page/base_scaffold.dart';
import 'package:rightflair/core/components/loading.dart';
import 'package:rightflair/feature/chat/cubit/chat_cubit.dart';
import 'package:rightflair/feature/chat/widgets/chat_app_bar.dart';
import 'package:rightflair/feature/chat/widgets/chat_messages_list.dart';
import 'package:rightflair/feature/chat/widgets/chat_input.dart';

class ChatPage extends StatelessWidget {
  final String conversationId;
  final String otherUserName;
  final String? otherUserPhoto;
  final String otherUserId;

  const ChatPage({
    super.key,
    required this.conversationId,
    required this.otherUserName,
    this.otherUserPhoto,
    required this.otherUserId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        conversationId: conversationId,
        otherUserName: otherUserName,
        otherUserPhoto: otherUserPhoto,
        otherUserId: otherUserId,
      ),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return BaseScaffold(
            appBar: ChatAppBarWidget(
              userName: otherUserName,
              userPhoto: otherUserPhoto,
              userId: otherUserId,
            ),
            body: Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? const LoadingComponent()
                      : ChatMessagesListWidget(messages: state.messages),
                ),
                ChatInputWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
