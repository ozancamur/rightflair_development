part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, success, failure }

class FeedState extends Equatable {
  final FeedStatus status;
  final int currentTabIndex;
  final Map<int, List<FeedPostModel>> tabPosts; // Her tab için post listesi
  final Map<int, bool> hasReachedMax; // Her tab için son post'a ulaşıldı mı
  final String? errorMessage;

  const FeedState({
    this.status = FeedStatus.initial,
    this.currentTabIndex = 0,
    this.tabPosts = const {},
    this.hasReachedMax = const {},
    this.errorMessage,
  });

  FeedState copyWith({
    FeedStatus? status,
    int? currentTabIndex,
    Map<int, List<FeedPostModel>>? tabPosts,
    Map<int, bool>? hasReachedMax,
    String? errorMessage,
  }) {
    return FeedState(
      status: status ?? this.status,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      tabPosts: tabPosts ?? this.tabPosts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Belirli bir tab'deki postları getir
  List<FeedPostModel> getPostsForTab(int tabIndex) {
    return tabPosts[tabIndex] ?? [];
  }

  /// Belirli bir tab'de post var mı?
  bool hasPostsForTab(int tabIndex) {
    final posts = tabPosts[tabIndex];
    return posts != null && posts.isNotEmpty;
  }

  /// Aktif tab'deki post sayısı
  int get currentTabPostCount => getPostsForTab(currentTabIndex).length;

  @override
  List<Object?> get props => [
    status,
    currentTabIndex,
    tabPosts,
    hasReachedMax,
    errorMessage,
  ];
}
