part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class LoadDiscoverFeedEvent extends FeedEvent {
  final int tabIndex;

  const LoadDiscoverFeedEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class LoadFollowingFeedEvent extends FeedEvent {
  final int tabIndex;

  const LoadFollowingFeedEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class LoadFriendsFeedEvent extends FeedEvent {
  final int tabIndex;

  const LoadFriendsFeedEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class LoadMorePostsEvent extends FeedEvent {
  final int tabIndex;

  const LoadMorePostsEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class ChangeTabEvent extends FeedEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class SwipeRightEvent extends FeedEvent {
  final int tabIndex;
  final String postId;

  const SwipeRightEvent({required this.tabIndex, required this.postId});

  @override
  List<Object?> get props => [tabIndex, postId];
}

class SwipeLeftEvent extends FeedEvent {
  final int tabIndex;
  final String postId;

  const SwipeLeftEvent({required this.tabIndex, required this.postId});

  @override
  List<Object?> get props => [tabIndex, postId];
}
