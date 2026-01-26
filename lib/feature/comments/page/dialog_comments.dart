import 'package:flutter/material.dart';

import '../../../feature/comments/page/comments_dialog_page.dart';

void dialogComments(
  BuildContext context, {
  required String postId,
  required VoidCallback onAddComment,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    builder: (context) =>
        CommentsDialogPage(postId: postId, onAddComment: onAddComment),
  ).whenComplete(() {
    // Klavyeyi kapat ve focus'u temizle
    FocusScope.of(context).unfocus();
  });
}
