part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final List<PhotoModel> photos;
  final List<PhotoModel> saves;
  final List<PhotoModel> drafts;
  const ProfileState({
    this.isLoading = false,
    this.photos = const [],
    this.saves = const [],
    this.drafts = const [],
  });

  ProfileState copyWith({
    bool? isLoading,
    List<PhotoModel>? photos,
    List<PhotoModel>? saves,
    List<PhotoModel>? drafts,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
      saves: saves ?? this.saves,
      drafts: drafts ?? this.drafts,
    );
  }

  @override
  List<Object> get props => [isLoading, photos, saves, drafts];
}
