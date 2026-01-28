import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/extensions/context.dart';
import 'package:rightflair/feature/navigation/page/feed/repository/feed_repository_impl.dart';

import '../bloc/feed_bloc.dart';
import '../widgets/feed_tab_views.dart';
import '../widgets/feed_tab_bars.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FeedBloc(FeedRepositoryImpl())..add(LoadPostInitializeEvent()),
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              right: context.width * .05,
              left: context.width * .05,
              bottom: context.height * .02,
            ),
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Column _body(BuildContext context) {
    return Column(children: [const FeedTabBars(), const FeedTabViews()]);
  }
}
