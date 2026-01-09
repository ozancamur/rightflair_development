import 'package:flutter/material.dart';

import '../../../../core/components/text.dart';
import '../../../../core/constants/dark_color.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/extensions/context.dart';

class PostUserInfoWidget extends StatelessWidget {
  const PostUserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String photo =
        "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    return Padding(
      padding: EdgeInsets.all(context.width * .04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: context.width * .03,
        children: [
          Container(
            height: context.height * .045,
            width: context.height * .045,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppDarkColors.WHITE75, width: .5),
              image: DecorationImage(
                image: NetworkImage(photo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          TextComponent(
            text: "Jennifer Coppen",
            size: FontSizeConstants.SMALL,
            color: AppDarkColors.PRIMARY,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
