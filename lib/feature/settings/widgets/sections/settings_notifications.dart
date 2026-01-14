import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/feature/settings/widgets/settings_divider.dart';

import '../../../../core/constants/dark_color.dart';
import '../../../../core/constants/string.dart';
import '../../../../core/extensions/context.dart';
import '../../cubit/settings_cubit.dart';
import '../settings_section_header_widget.dart';
import '../settings_toggle_item_widget.dart';

class SettingsNotificationsWidget extends StatelessWidget {
  final bool likes;
  final bool saves;
  final bool milestones;
  final bool trending;
  final bool follow;

  const SettingsNotificationsWidget({
    super.key,
    required this.likes,
    required this.saves,
    required this.milestones,
    required this.trending,
    required this.follow,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeaderWidget(title: AppStrings.SETTINGS_NOTIFICATIONS),
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.width * 0.04),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: .5, color: AppDarkColors.WHITE50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _likes(cubit),
              const SettingsDividerWidget(),
              _saves(cubit),
              const SettingsDividerWidget(),
              _milestones(cubit),
              const SettingsDividerWidget(),
              _trending(cubit),
              const SettingsDividerWidget(),
              _follow(cubit),
            ],
          ),
        ),
      ],
    );
  }

  SettingsToggleItemWidget _likes(SettingsCubit cubit) {
    return SettingsToggleItemWidget(
      title: AppStrings.SETTINGS_LIKES,
      value: likes,
      onChanged: cubit.toggleLikes,
    );
  }

  SettingsToggleItemWidget _saves(SettingsCubit cubit) {
    return SettingsToggleItemWidget(
      title: AppStrings.SETTINGS_SAVES,
      value: saves,
      onChanged: cubit.toggleSaves,
    );
  }

  SettingsToggleItemWidget _milestones(SettingsCubit cubit) {
    return SettingsToggleItemWidget(
      title: AppStrings.SETTINGS_MILESTONES,
      value: milestones,
      onChanged: cubit.toggleMilestones,
    );
  }

  SettingsToggleItemWidget _trending(SettingsCubit cubit) {
    return SettingsToggleItemWidget(
      title: AppStrings.SETTINGS_TRENDING,
      value: trending,
      onChanged: cubit.toggleTrending,
    );
  }

  SettingsToggleItemWidget _follow(SettingsCubit cubit) {
    return SettingsToggleItemWidget(
      title: AppStrings.SETTINGS_FOLLOW,
      value: follow,
      onChanged: cubit.toggleFollow,
    );
  }
}
