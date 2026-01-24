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
      create: (context) => FeedBloc(FeedRepositoryImpl())..add(LoadPostInitializeEvent()),
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .05),
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
