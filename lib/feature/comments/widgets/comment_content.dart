import 'package:flutter/material.dart';

import '../../../core/extensions/context.dart';
import '../../navigation/page/feed/models/comment.dart';
import 'content/comment_replies_button.dart';
import 'content/comment_text.dart';
import 'content/comment_time_and_reply.dart';
import 'content/comment_username.dart';

class CommentContentWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentContentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username
          CommentUsernameWidget(
            username: comment.user?.username ?? "rightflair_user",
          ),
          SizedBox(height: context.width * 0.005),

          // Comment Text
          CommentTextWidget(text: comment.content ?? ""),

          SizedBox(height: context.width * 0.01),

          // Time and Reply
          CommentTimeAndReplyWidget(
            createdAt: comment.createdAt ?? DateTime.now(),
          ),

          // View Replies Button
          if (comment.replies?.length != 0)
            CommentRepliesButtonWidget(replyCount: comment.repliesCount ?? 0),
        ],
      ),
    );
  }
}
