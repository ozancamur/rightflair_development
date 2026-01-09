import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/constants/dark_color.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../cubit/navigation_cubit.dart';
import '../widgets/navigation_bottom_bar.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppDarkColors.SECONDARY,
          body: _body(context, state),
          bottomNavigationBar: NavigationBottomBar(currentIndex: state.currentIndex),
        );
      },
    );
  }

  SizedBox _body(BuildContext context, NavigationState state) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: context.read<NavigationCubit>().controller,
        itemCount: state.pages.length,
        itemBuilder: (context, index) => state.pages[index],
      ),
    );
  }
}
