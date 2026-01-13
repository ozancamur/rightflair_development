part of 'post_detail_cubit.dart';

class PostDetailState extends Equatable {
  final FeedPostModel post;
  final bool isBookmarked;

  const PostDetailState({required this.post, required this.isBookmarked});

  PostDetailState copyWith({FeedPostModel? post, bool? isBookmarked}) {
    return PostDetailState(
      post: post ?? this.post,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object> get props => [post, isBookmarked];
}
