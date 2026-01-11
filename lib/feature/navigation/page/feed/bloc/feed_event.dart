part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

/// Feed verilerini yükle
class LoadFeedEvent extends FeedEvent {
  final int tabIndex;

  const LoadFeedEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

/// Bir post'u sağa kaydır (beğen)
class SwipeRightEvent extends FeedEvent {
  final int tabIndex;
  final String postId;

  const SwipeRightEvent({required this.tabIndex, required this.postId});

  @override
  List<Object?> get props => [tabIndex, postId];
}

/// Bir post'u sola kaydır (beğenme)
class SwipeLeftEvent extends FeedEvent {
  final int tabIndex;
  final String postId;

  const SwipeLeftEvent({required this.tabIndex, required this.postId});

  @override
  List<Object?> get props => [tabIndex, postId];
}

/// Daha fazla post yükle
class LoadMorePostsEvent extends FeedEvent {
  final int tabIndex;

  const LoadMorePostsEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

/// Tab değiştirildiğinde
class ChangeTabEvent extends FeedEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
