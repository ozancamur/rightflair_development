import 'package:flutter/material.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../widgets/feed_tab_views.dart';
import '../widgets/feed_tab_bars.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * .05),
          child: _body(context),
        ),
      ),
    );
  }

  Column _body(BuildContext context) {
    return Column(children: [FeedTabBars(), FeedTabViews()]);
  }
}
