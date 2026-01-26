import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../create_post/model/post.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit() : super(PostDetailState(post: PostModel()));

  void init({required PostModel post}) => emit(state.copyWith(post: post));

  void addComment() {
    final updatedPost = state.post.copyWith(
      commentsCount: (state.post.commentsCount ?? 0) + 1,
    );

    emit(state.copyWith(post: updatedPost));
  }
}
