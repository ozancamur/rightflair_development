part of 'user_cubit.dart';

class UserState extends Equatable {
  final bool isLoading;
  final List<PhotoModel> photos;
  const UserState({this.isLoading = false, this.photos = const []});

  UserState copyWith({bool? isLoading, List<PhotoModel>? photos}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
    );
  }

  @override
  List<Object> get props => [isLoading, photos];
}
