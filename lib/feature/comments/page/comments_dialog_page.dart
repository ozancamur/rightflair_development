import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/components/loading.dart';

import '../../../core/components/drag_handle.dart';
import '../../../core/extensions/context.dart';
import '../../navigation/page/feed/bloc/feed_bloc.dart';
import '../widgets/add_comment.dart';
import '../widgets/comments_header.dart';
import '../widgets/comments_list.dart';

class CommentsDialogPage extends StatefulWidget {
  final String postId;

  const CommentsDialogPage({super.key, required this.postId});

  @override
  State<CommentsDialogPage> createState() => _CommentsDialogPageState();
}

class _CommentsDialogPageState extends State<CommentsDialogPage> {
  bool _isReply = false;
  String? _commentId;
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(LoadPostCommentsEvent(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return Container(
          height: context.height * 0.85,
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.width * 0.05),
              topRight: Radius.circular(context.width * 0.05),
            ),
          ),
          child: state.isLoadingComments
              ? LoadingComponent()
              : Column(
                  children: [
                    const DragHandleComponent(),
                    CommentsHeaderWidget(
                      commentCount: state.comments?.length ?? 0,
                    ),
                    Container(
                      height: context.height * 0.001,
                      color: context.colors.primaryFixedDim,
                    ),
                    CommentsListWidget(
                      comments: state.comments ?? [],
                      onReply: (String commentId) {
                        setState(() {
                          if (_commentId == commentId) {
                            _isReply = !_isReply;
                          } else {
                            _commentId = commentId;
                            _isReply = true;
                          }
                        });
                      },
                    ),
                    AddCommentWidget(
                      isReply: _isReply,
                      onAddComment: (text) => context.read<FeedBloc>().add(
                        SendCommentToPostEvent(
                          postId: widget.postId,
                          content: text,
                          parentId: _isReply ? _commentId : null,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
