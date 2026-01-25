import 'package:flutter/material.dart';

import '../../../feature/comments/page/comments_dialog_page.dart';

void dialogComments(
  BuildContext context, {
  required String postId,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) =>
        CommentsDialogPage(postId: postId),
  );
}
