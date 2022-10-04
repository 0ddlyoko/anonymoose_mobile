part of 'new_tweet_bloc.dart';

class NewTweetState extends Equatable {

  final String? tweetId;
  final bool display;
  final String title;
  final String description;

  const NewTweetState({
    this.tweetId,
    this.display = true,
    this.title = "",
    this.description = "",
  });

  NewTweetState copyWith({
    String? tweetId,
    bool? display,
    String? title,
    String? description,
  }) {
    return NewTweetState(
      tweetId: tweetId ?? this.tweetId,
      display: display ?? this.display,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [tweetId, display, title, description];
}
