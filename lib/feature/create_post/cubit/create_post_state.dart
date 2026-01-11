part of 'create_post_cubit.dart';

class CreatePostState {
  final bool isAnonymous;
  final bool allowComments;
  // Add other necessary fields here

  const CreatePostState({this.isAnonymous = false, this.allowComments = true});

  CreatePostState copyWith({bool? isAnonymous, bool? allowComments}) {
    return CreatePostState(
      isAnonymous: isAnonymous ?? this.isAnonymous,
      allowComments: allowComments ?? this.allowComments,
    );
  }
}
