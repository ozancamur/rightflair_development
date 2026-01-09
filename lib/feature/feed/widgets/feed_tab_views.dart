import 'package:flutter/material.dart';

class FeedTabViews extends StatelessWidget {
  const FeedTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Center(
            child: Text(
              'Content for Tab 1',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Content for Tab 2',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Content for Tab 3',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
