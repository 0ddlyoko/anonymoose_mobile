part of 'tweet_bloc.dart';

enum TweetStatus { initial, loadComments, success, error }

class TweetState extends Equatable {
  final TweetStatus status;
  final String tweetId;
  Tweet? tweet;
  final Tweet? parent;
  final List<Tweet> children;

  TweetState({
    this.status = TweetStatus.initial,
    required this.tweetId,
    this.tweet,
    this.parent,
    this.children = const [],
  });

  TweetState copyWith({
    TweetStatus? status,
    String? tweetId,
    Tweet? tweet,
    Tweet? parent,
    List<Tweet>? children,
  }) {
    return TweetState(
      status: status ?? this.status,
      tweetId: tweetId ?? this.tweetId,
      tweet: tweet ?? this.tweet,
      parent: parent ?? this.parent,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [status, tweetId, tweet, parent, children];
}
