import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rightflair/core/components/text.dart';
import 'package:rightflair/core/constants/font_size.dart';

import '../constants/dark_color.dart';
import '../extensions/context.dart';

class PostIconButtonComponent extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final int value;
  const PostIconButtonComponent({
    super.key,
    required this.onTap,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: context.height * .005,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: context.height * .05,
            width: context.height * .05,
            padding: EdgeInsets.all(context.width * .025),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppDarkColors.WHITE16,
              border: Border.all(color: AppDarkColors.WHITE32, width: 1),
            ),
            child: SvgPicture.asset(icon),
          ),
        ),
        TextComponent(
          text: value.toString(),
          size: FontSizeConstants.XXX_SMALL,
          weight: FontWeight.w500,
        ),
      ],
    );
  }
}
