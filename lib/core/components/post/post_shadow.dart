import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/color/color.dart';

import '../../extensions/context.dart';

class PostShadowComponent extends StatelessWidget {
  const PostShadowComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .4,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.width * 0.06),
        gradient: LinearGradient(
          colors: AppColors.SHADOWS,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}
