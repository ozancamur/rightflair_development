import 'package:flutter/material.dart';

import '../../../../../core/components/profile/profile_photo_grid_widget.dart';
import '../../../../../core/extensions/context.dart';
import '../model/photo.dart';

class ProfileTabViewsWidget extends StatelessWidget {
  final List<PhotoModel> photos;
  final List<PhotoModel> saves;
  final List<PhotoModel> drafts;
  const ProfileTabViewsWidget({
    super.key,
    required this.photos,
    required this.saves,
    required this.drafts,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.55,
      child: TabBarView(
        children: [
          ProfilePhotoGridWidget(photos: photos),
          ProfilePhotoGridWidget(photos: saves),
          ProfilePhotoGridWidget(photos: drafts),
        ],
      ),
    );
  }
}
