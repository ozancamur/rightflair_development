import 'package:flutter/material.dart';

import '../../navigation/page/feed/models/comment.dart';
import 'comment_avatar.dart';
import 'comment_content.dart';
import 'content/comment_like_button.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CommentAvatarWidget(
                avatar: comment.user?.profilePhotoUrl,
                username: comment.user?.username ?? "rightflair_user",
              ),
              const SizedBox(width: 12),

              // Comment Content
              CommentContentWidget(comment: comment),

              // Like Button
              CommentLikeButtonWidget(
                isLiked: comment.isLiked ?? false,
                likeCount: comment.likesCount ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
