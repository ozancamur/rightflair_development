part of 'choose_username_cubit.dart';

const _undefined = Object();

class ChooseUsernameState extends Equatable {
  final bool isLoading;
  final bool? isUnique;
  final String? checkedUsername;
  final List<String>? suggestions;
  const ChooseUsernameState({
    this.isLoading = false,
    this.isUnique,
    this.checkedUsername,
    this.suggestions,
  });

  ChooseUsernameState copyWith({
    bool? isLoading,
    Object? isUnique = _undefined,
    Object? checkedUsername = _undefined,
    Object? suggestions = _undefined,
  }) {
    return ChooseUsernameState(
      isLoading: isLoading ?? this.isLoading,
      isUnique: isUnique == _undefined ? this.isUnique : isUnique as bool?,
      checkedUsername: checkedUsername == _undefined
          ? this.checkedUsername
          : checkedUsername as String?,
      suggestions: suggestions == _undefined
          ? this.suggestions
          : suggestions as List<String>?,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isUnique,
    checkedUsername,
    suggestions,
  ];
}
