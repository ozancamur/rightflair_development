import 'package:flutter/material.dart';

import '../../../../../../core/constants/icons.dart';
import '../../../../../../core/extensions/context.dart';
import '../../../../../comments/examples/comments_dialog_example.dart';
import 'post_action_icon.dart';

class PostActionsWidget extends StatelessWidget {
  final int comment;
  final int like;
  final int share;
  const PostActionsWidget({
    super.key,
    required this.comment,
    required this.like,
    required this.share,
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
            onTap: () => CommentsDialogExample.showCommentsDialog(context),
            icon: AppIcons.MESSAGE_FILLED,
            value: comment,
          ),
          PostIconButtonWidget(
            onTap: () {},
            icon: AppIcons.SAVE_FILLED,
            value: share,
          ),
          PostIconButtonWidget(
            onTap: () {},
            icon: AppIcons.SHARE_FILLED,
            value: like,
          ),
        ],
      ),
    );
  }
}
