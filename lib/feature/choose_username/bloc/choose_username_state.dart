part of 'choose_username_cubit.dart';

class ChooseUsernameState extends Equatable {
  final bool isLoading;
  final bool isUnique;
  const ChooseUsernameState({this.isLoading = false, this.isUnique = false});

  ChooseUsernameState copyWith({bool? isLoading, bool? isUnique}) {
    return ChooseUsernameState(
      isLoading: isLoading ?? this.isLoading,
      isUnique: isUnique ?? this.isUnique,
    );
  }

  @override
  List<Object> get props => [isLoading, isUnique];
}
