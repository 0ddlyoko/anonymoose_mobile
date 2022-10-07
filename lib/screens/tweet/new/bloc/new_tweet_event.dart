part of 'new_tweet_bloc.dart';

@immutable
abstract class NewTweetEvent extends Equatable {}

class NewTweetDisplayChanged extends NewTweetEvent {
  NewTweetDisplayChanged(this.display);

  final bool display;

  @override
  List<Object?> get props => [display];
}

class NewTweetTitleChanged extends NewTweetEvent {
  NewTweetTitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

class NewTweetDescriptionChanged extends NewTweetEvent {
  NewTweetDescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class NewTweetSubmitted extends NewTweetEvent {

  @override
  List<Object?> get props => [];
}
