import 'package:flutter/material.dart';
import 'package:rightflair/core/extensions/context.dart';
import 'package:rightflair/feature/chat/model/chat_message.dart';
import 'package:rightflair/feature/chat/widgets/chat_message/message_content.dart';

import 'chat_message/message_avatar.dart';
import 'chat_message/message_is_read_indicator.dart';
import 'chat_message/message_time.dart';

class MessageBubbleWidget extends StatelessWidget {
  final ChatMessageModel message;
  final bool isNextMessageSameSender;

  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.isNextMessageSameSender,
  });

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = message.isOwnMessage ?? false;

    return Padding(
      padding: EdgeInsets.only(
        bottom: isNextMessageSameSender
            ? context.height * 0.004
            : context.height * 0.012,
      ),
      child: Row(
        mainAxisAlignment: isOwnMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isOwnMessage) ...[
            MessageAvatar(
              isNextMessageSameSender: isNextMessageSameSender,
              profilePhotoUrl: message.sender?.profilePhotoUrl,
            ),
            SizedBox(width: context.width * 0.02),
          ],
          _content(isOwnMessage, context),
          if (isOwnMessage) ...[
            SizedBox(width: context.width * 0.02),
            MessageIsReadIndicatorWidget(
              isNextMessageSameSender: isNextMessageSameSender,
              isRead: message.isRead,
            ),
          ],
        ],
      ),
    );
  }

  Flexible _content(bool isOwnMessage, BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: isOwnMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          MessageContentWidget(
            isOwnMessage: isOwnMessage,
            imageUrl: message.imageUrl,
            content: message.content,
          ),
          if (!isNextMessageSameSender) ...[
            SizedBox(height: context.height * 0.003),
            MessageTimeWidget(createdAt: message.createdAt),
          ],
        ],
      ),
    );
  }
}
