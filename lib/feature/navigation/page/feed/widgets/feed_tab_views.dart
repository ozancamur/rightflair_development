import 'package:flutter/material.dart';

import 'swipeable_post_stack.dart';

class FeedTabViews extends StatelessWidget {
  const FeedTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Tab 0 - Trend
          SwipeablePostStack(tabIndex: 0),
          // Tab 1 - Takip
          SwipeablePostStack(tabIndex: 1),
          // Tab 2 - Keşfet
          SwipeablePostStack(tabIndex: 2),
        ],
      ),
    );
  }
}
