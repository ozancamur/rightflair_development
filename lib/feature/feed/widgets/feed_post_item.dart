import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/icons.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../../../core/components/post_icon_button.dart';
import 'post/post_shadow.dart';
import 'post/post_user_info.dart';

class FeedPostItem extends StatelessWidget {
  const FeedPostItem({super.key});

  @override
  Widget build(BuildContext context) {
    final String url =
        "https://static.ticimax.cloud/cdn-cgi/image/width=851,quality=99/6601//uploads/editoruploads/smart-casual-kombinleri-3.jpg";
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const PostShadowWidget(),
          const PostUserInfoWidget(),
          Positioned(
            right: context.width * .04,
            bottom: context.width * .08,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: context.height * .01,
              children: [
                PostIconButtonComponent(
                  onTap: () {},
                  icon: AppIcons.MESSAGE_FILLED,
                  value: 234,
                ),
                PostIconButtonComponent(
                  onTap: () {},
                  icon: AppIcons.SAVE_FILLED,
                  value: 53,
                ),
                PostIconButtonComponent(
                  onTap: () {},
                  icon: AppIcons.SHARE_FILLED,
                  value: 27,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
