import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/dark_color.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppDarkColors.ORANGE),
    );
  }
}
