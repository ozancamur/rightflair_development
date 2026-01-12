import 'package:flutter/material.dart';

import '../../../../../../core/extensions/context.dart';
import 'suggested_account_image.dart';
import 'suggested_account_more_button.dart';
import 'suggested_account_user.dart';

class SuggestedAccountItemWidget extends StatelessWidget {
  final String username;
  final String handle;
  final String profileImage;

  const SuggestedAccountItemWidget({
    super.key,
    required this.username,
    required this.handle,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(context.width * 0.03),
      ),
      child: Row(
        children: [
          // Profile image
          SuggestedAccountImageWidget(image: profileImage),
          SizedBox(width: context.width * 0.03),

          // Username and handle
          SuggestedAccountUserWidget(username: username, handle: handle),

          // More button
          const SuggestedAccountMoreButtonWidget(),
        ],
      ),
    );
  }
}
