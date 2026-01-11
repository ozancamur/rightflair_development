import 'package:flutter/material.dart';
import 'package:rightflair/feature/comments/widgets/comments_dialog.dart';

/// Example usage of CommentsDialog
///
/// This file demonstrates how to use the CommentsDialog widget
/// You can call showCommentsDialog from any screen where you want to display comments
class CommentsDialogExample {
  /// Show the comments dialog
  static void showCommentsDialog(BuildContext context) {
    // Sample comments data
    final List<Comment> sampleComments = [
      Comment(
        userName: 'sarah',
        text:
            'This outfit is absolutely stunning! Where did you get those pants?',
        timeAgo: '2h',
        likeCount: 12,
        isLiked: false,
        replyCount: 8,
      ),
      Comment(
        userName: 'sarah',
        text:
            'This outfit is absolutely stunning! Where did you get those pants?',
        timeAgo: '2h',
        likeCount: 12,
        isLiked: false,
        replyCount: 0,
      ),
      Comment(
        userName: 'sarah',
        text:
            'This outfit is absolutely stunning! Where did you get those pants?',
        timeAgo: '2h',
        likeCount: 12,
        isLiked: false,
        replyCount: 0,
      ),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CommentsDialog(
        commentCount: 122,
        comments: sampleComments,
        onAddComment: (commentText) {
          // Handle adding new comment
          print('New comment: $commentText');
          // Here you would typically:
          // 1. Send the comment to your backend
          // 2. Update the comments list
          // 3. Refresh the UI
        },
      ),
    );
  }
}

/// Example screen showing how to trigger the comments dialog
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            CommentsDialogExample.showCommentsDialog(context);
          },
          child: const Text('Show Comments'),
        ),
      ),
    );
  }
}
