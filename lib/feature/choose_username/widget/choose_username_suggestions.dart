import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rightflair/core/components/text/text.dart';
import 'package:rightflair/core/constants/color/color.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import 'package:rightflair/core/constants/icons.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../../../core/constants/string.dart';
import '../cubit/choose_username_cubit.dart';

class ChooseUsernameSuggestions extends StatelessWidget {
  final List<String> suggestions;
  const ChooseUsernameSuggestions({super.key, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.height * .01,
        children: [
          TextComponent(
            text: AppStrings.CHOOSE_USERNAME_SUGGESTIONS,
            color: context.colors.primary,
            size: FontSizeConstants.X_SMALL,
            weight: FontWeight.w600,
          ),
          Container(
            width: context.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: context.colors.onPrimaryFixed,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: context.height * .005),
              itemCount: suggestions.length,
              separatorBuilder: (context, index) =>
                  Divider(color: context.colors.onPrimaryFixed, height: 10),
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return _suggestion(context, suggestion);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggestion(BuildContext context, String suggestion) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        final cubit = context.read<ChooseUsernameCubit>();
        cubit.controller.text = suggestion;
        cubit.onTextChanged();
      },
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
          vertical: context.height * .01,
          horizontal: context.width * .04,
        ),
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextComponent(
              text: suggestion,
              color: context.colors.primary,
              size: FontSizeConstants.XX_SMALL,
              weight: FontWeight.w500,
              tr: false,
            ),
            SvgPicture.asset(
              AppIcons.CHECK,
              height: context.height * .015,
              color: AppColors.GREEN,
            ),
          ],
        ),
      ),
    );
  }
}
