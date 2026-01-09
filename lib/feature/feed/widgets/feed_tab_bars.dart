import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/dark_color.dart';
import 'package:rightflair/core/constants/font_family.dart';

import '../../../core/constants/string.dart';
import '../../../core/extensions/context.dart';

class FeedTabBars extends StatelessWidget {
  const FeedTabBars({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .1,
      width: context.width,
      child: Center(
        child: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.only(
            left: context.width * .03,
            right: context.width * .03,
            top: 0,
          ),
          labelPadding: EdgeInsets.symmetric(horizontal: context.width * .025),
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamilyConstants.POPPINS,
          ),
          unselectedLabelStyle: TextStyle(
            color: AppDarkColors.WHITE75,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamilyConstants.POPPINS,
          ),
          tabs: [
            Tab(text: AppStrings.FEED_DISCOVER.tr()),
            Tab(text: AppStrings.FEED_FOLLOWING.tr()),
            Tab(text: AppStrings.FEED_FRIENDS.tr()),
          ],
        ),
      ),
    );
  }
}
