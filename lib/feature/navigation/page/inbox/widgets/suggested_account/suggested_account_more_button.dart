import 'package:flutter/material.dart';

class SuggestedAccountMoreButtonWidget extends StatelessWidget {
  const SuggestedAccountMoreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_horiz, color: Colors.white),
      onPressed: () {},
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
