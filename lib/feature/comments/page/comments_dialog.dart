import 'package:flutter/material.dart';

import '../../../core/components/drag_handle.dart';
import '../../../core/extensions/context.dart';
import '../model/comment.dart';
import '../widgets/add_comment.dart';
import '../widgets/comments_header.dart';
import '../widgets/comments_list.dart';

class CommentsDialog extends StatelessWidget {
  final List<CommentModel> comments;
  final Function(String) onAddComment;

  const CommentsDialog({
    super.key,
    required this.comments,
    required this.onAddComment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.85,
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.width * 0.05),
          topRight: Radius.circular(context.width * 0.05),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          const DragHandleComponent(),

          // Header
          CommentsHeaderWidget(commentCount: comments.length),

          // Divider
          Container(
            height: context.height * 0.001,
            color: context.colors.primaryFixedDim,
          ),

          // Comments List
          CommentsListWidget(list: comments),

          // Add Comment Section
          AddCommentWidget(onAddComment: onAddComment),
        ],
      ),
    );
  }
}
