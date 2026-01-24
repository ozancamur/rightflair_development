part of 'feed_bloc.dart';

class FeedState extends Equatable {
  final int currentTabIndex;
  final String? error;
  final List<PostModel>? posts;
  final PaginationModel? pagination;
  final bool isLoading;
  final bool isLoadingMore;

  const FeedState({
    this.currentTabIndex = 0,
    this.error,
    this.posts,
    this.pagination,
    this.isLoading = false,
    this.isLoadingMore = false,
  });

  FeedState copyWith({
    int? currentTabIndex,
    String? error,
    List<PostModel>? posts,
    PaginationModel? pagination,
    bool? isLoading,
    bool? isLoadingMore,
  }) {
    return FeedState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    currentTabIndex,
    error,
    posts,
    pagination,
    isLoading,
    isLoadingMore,
  ];
}
