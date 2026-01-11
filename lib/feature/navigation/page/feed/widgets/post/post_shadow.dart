import 'package:flutter/material.dart';

import '../../../../../../core/constants/dark_color.dart';
import '../../../../../../core/extensions/context.dart';

class PostShadowWidget extends StatelessWidget {
  const PostShadowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .4,
      width: context.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppDarkColors.SHADOW,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}
