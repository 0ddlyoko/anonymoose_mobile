part of 'tweet_bloc.dart';

@immutable
abstract class TweetEvent extends Equatable {}

class TweetLoadEvent extends TweetEvent {
  @override
  List<Object?> get props => [];
}
