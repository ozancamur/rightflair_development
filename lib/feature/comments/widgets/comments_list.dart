import 'package:flutter/material.dart';

import '../../navigation/page/feed/models/comment.dart';
import 'comment.dart';

class CommentsListWidget extends StatelessWidget {
  final List<CommentModel> comments;
  CommentsListWidget({super.key, required this.comments});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final CommentModel comment = comments[index];
          return CommentWidget(comment: comment);
        },
      ),
    );
  }
}
