import 'package:flutter/material.dart';

import '../../../../../../core/constants/icons.dart';
import '../../../../../../core/extensions/context.dart';
import 'post_action_icon.dart';

class PostActionsWidget extends StatelessWidget {
  final int comment;
  final int saved;
  final int shared;
  final VoidCallback onComment;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final String postId;
  const PostActionsWidget({
    super.key,
    required this.comment,
    required this.saved,
    required this.shared,
    required this.postId,
    required this.onComment,
    required this.onSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: context.width * .04,
      bottom: context.width * .08,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: context.height * .01,
        children: [
          PostIconButtonWidget(
            onTap: onComment,
            icon: AppIcons.MESSAGE_FILLED,
            value: comment,
          ),
          PostIconButtonWidget(
            onTap: onSave,
            icon: AppIcons.SAVE_FILLED,
            value: saved,
          ),
          PostIconButtonWidget(
            onTap: onShare,
            icon: AppIcons.SHARE_FILLED,
            value: shared,
          ),
        ],
      ),
    );
  }
}
