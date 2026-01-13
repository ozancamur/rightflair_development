import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/photo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
    : super(
        ProfileState(
          photos: [
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1657460312/tr/foto%C4%9Fraf/beautiful-sensual-woman.jpg?s=1024x1024&w=is&k=20&c=mpNuQR920Mv2wZoFr-J13OOjS_rjcNNVZmusAvqMYV8=',
              viewed: 1242,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1362588255/tr/foto%C4%9Fraf/beautiful-brunette-woman-walking-on-sunset-beach-in-fashionable-maxi-dress-relaxing-on.jpg?s=1024x1024&w=is&k=20&c=hKza9LJ80QTYijNY1kMKKuRjhA6J00-1x8gh943g0gc=',

              viewed: 432,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1311415818/tr/foto%C4%9Fraf/giyindim-ve-hayallerimin-pe%C5%9Finden-gitmeye-haz%C4%B1r.jpg?s=1024x1024&w=is&k=20&c=UMSoGayVya20IjU0AKsGNs1EnFf_HKZ7pX-B5_MliM0=',
              viewed: 521,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1462655622/tr/foto%C4%9Fraf/beautiful-woman-in-a-leather-suit-looking-masculine.jpg?s=1024x1024&w=is&k=20&c=z3rSRE4jNYtQ0lD2Lzn0_idWA-o9SElixR-qwY3M4Ss=',
              viewed: 1,
            ),
          ],
          saves: [
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1462655622/tr/foto%C4%9Fraf/beautiful-woman-in-a-leather-suit-looking-masculine.jpg?s=1024x1024&w=is&k=20&c=z3rSRE4jNYtQ0lD2Lzn0_idWA-o9SElixR-qwY3M4Ss=',
              viewed: 521,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1362588255/tr/foto%C4%9Fraf/beautiful-brunette-woman-walking-on-sunset-beach-in-fashionable-maxi-dress-relaxing-on.jpg?s=1024x1024&w=is&k=20&c=hKza9LJ80QTYijNY1kMKKuRjhA6J00-1x8gh943g0gc=',

              viewed: 3251,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1657460312/tr/foto%C4%9Fraf/beautiful-sensual-woman.jpg?s=1024x1024&w=is&k=20&c=mpNuQR920Mv2wZoFr-J13OOjS_rjcNNVZmusAvqMYV8=',
              viewed: 42,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1311415818/tr/foto%C4%9Fraf/giyindim-ve-hayallerimin-pe%C5%9Finden-gitmeye-haz%C4%B1r.jpg?s=1024x1024&w=is&k=20&c=UMSoGayVya20IjU0AKsGNs1EnFf_HKZ7pX-B5_MliM0=',
              viewed: 126,
            ),
          ],
          drafts: [
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1657460312/tr/foto%C4%9Fraf/beautiful-sensual-woman.jpg?s=1024x1024&w=is&k=20&c=mpNuQR920Mv2wZoFr-J13OOjS_rjcNNVZmusAvqMYV8=',
              viewed: 425,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1462655622/tr/foto%C4%9Fraf/beautiful-woman-in-a-leather-suit-looking-masculine.jpg?s=1024x1024&w=is&k=20&c=z3rSRE4jNYtQ0lD2Lzn0_idWA-o9SElixR-qwY3M4Ss=',
              viewed: 645,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1311415818/tr/foto%C4%9Fraf/giyindim-ve-hayallerimin-pe%C5%9Finden-gitmeye-haz%C4%B1r.jpg?s=1024x1024&w=is&k=20&c=UMSoGayVya20IjU0AKsGNs1EnFf_HKZ7pX-B5_MliM0=',
              viewed: 14215,
            ),
            PhotoModel(
              url:
                  'https://media.istockphoto.com/id/1362588255/tr/foto%C4%9Fraf/beautiful-brunette-woman-walking-on-sunset-beach-in-fashionable-maxi-dress-relaxing-on.jpg?s=1024x1024&w=is&k=20&c=hKza9LJ80QTYijNY1kMKKuRjhA6J00-1x8gh943g0gc=',

              viewed: 2,
            ),
          ],
        ),
      );
}
