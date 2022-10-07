part of 'new_tweet_bloc.dart';

enum NewTweetStatus {
  creating,
  sending,
  success,
  error,
}

class NewTweetState extends Equatable {

  final String? tweetId;
  final bool display;
  final String title;
  final String description;
  final NewTweetStatus status;

  const NewTweetState({
    this.tweetId,
    this.display = true,
    this.title = "",
    this.description = "",
    this.status = NewTweetStatus.creating,
  });

  NewTweetState copyWith({
    String? tweetId,
    bool? display,
    String? title,
    String? description,
    NewTweetStatus? status,
  }) {
    return NewTweetState(
      tweetId: tweetId ?? this.tweetId,
      display: display ?? this.display,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, tweetId, display, title, description];
}
