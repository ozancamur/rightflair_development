import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/feed_bloc.dart';
import '../models/feed_post_model.dart';
import 'feed_post_item.dart';

class SwipeablePostStack extends StatefulWidget {
  final int tabIndex;

  const SwipeablePostStack({super.key, required this.tabIndex});

  @override
  State<SwipeablePostStack> createState() => _SwipeablePostStackState();
}

class _SwipeablePostStackState extends State<SwipeablePostStack> {
  @override
  void initState() {
    super.initState();
    // Tab açıldığında postları yükle
    context.read<FeedBloc>().add(LoadFeedEvent(widget.tabIndex));
  }

  void _onSwipeComplete(String postId, SwipeDirection direction) {
    final bloc = context.read<FeedBloc>();

    if (direction == SwipeDirection.right) {
      bloc.add(SwipeRightEvent(tabIndex: widget.tabIndex, postId: postId));
    } else if (direction == SwipeDirection.left) {
      bloc.add(SwipeLeftEvent(tabIndex: widget.tabIndex, postId: postId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state.status == FeedStatus.loading &&
            !state.hasPostsForTab(widget.tabIndex)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == FeedStatus.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Bir hata oluştu',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<FeedBloc>().add(
                      LoadFeedEvent(widget.tabIndex),
                    );
                  },
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          );
        }

        final posts = state.getPostsForTab(widget.tabIndex);

        if (posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Henüz gösterilecek post yok',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<FeedBloc>().add(
                      LoadFeedEvent(widget.tabIndex),
                    );
                  },
                  child: const Text('Yenile'),
                ),
              ],
            ),
          );
        }

        // En fazla 3 kart göster (stack effect için)
        final displayPosts = posts.take(3).toList();

        return Stack(
          children: List.generate(displayPosts.length, (index) {
            final post = displayPosts[displayPosts.length - 1 - index];
            final isTop = index == displayPosts.length - 1;

            return _buildCard(
              post: post,
              index: index,
              totalCards: displayPosts.length,
              isTop: isTop,
            );
          }),
        );
      },
    );
  }

  Widget _buildCard({
    required FeedPostModel post,
    required int index,
    required int totalCards,
    required bool isTop,
  }) {
    // Tüm kartlar aynı boyutta
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !isTop,
        child: FeedPostItem(
          post: post,
          onSwipeComplete: isTop ? _onSwipeComplete : null,
        ),
      ),
    );
  }
}
