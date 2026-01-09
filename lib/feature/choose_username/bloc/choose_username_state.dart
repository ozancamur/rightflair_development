part of 'choose_username_bloc.dart';

class ChooseUsernameState extends Equatable {
  final bool isUnique;
  const ChooseUsernameState({this.isUnique = false});

  ChooseUsernameState copyWith({bool? isUnique}) {
    return ChooseUsernameState(isUnique: isUnique ?? this.isUnique);
  }

  @override
  List<Object> get props => [isUnique];
}
