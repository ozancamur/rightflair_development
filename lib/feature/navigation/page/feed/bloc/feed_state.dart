part of 'feed_bloc.dart';

class FeedState extends Equatable {
  final int currentTabIndex;
  final String? error;
  final bool isLoading;
  final List<PostModel>? posts;
  final PaginationModel? pagination;
  final bool isLoadingMore;

  const FeedState({
    this.currentTabIndex = 0,
    this.error,
    this.isLoading = false,
    this.posts,
    this.pagination,
    this.isLoadingMore = false,
  });

  FeedState copyWith({
    int? currentTabIndex,
    String? error,
    bool? isLoading,
    List<PostModel>? posts,
    PaginationModel? pagination,
    bool? isLoadingMore,
  }) {
    return FeedState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    currentTabIndex,
    error,
    isLoading,
    posts,
    pagination,
    isLoadingMore,
  ];
}
