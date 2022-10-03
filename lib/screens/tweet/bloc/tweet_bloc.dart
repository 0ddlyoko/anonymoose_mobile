import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/models/tweet/tweet.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  TweetBloc({
    required this.api,
    required String tweetId,
  }) : super(TweetState(
    tweetId: tweetId,
  )) {
    on<TweetLoadEvent>(_onTweetLoadEvent);
  }

  NetworkApi api;

  void _onTweetLoadEvent(TweetLoadEvent event, Emitter<TweetState> emit) async {
    // Load tweet
    await api.getTweet(state.tweetId)
      .then((value) async {
        emit(state.copyWith(status: TweetStatus.loadComments, tweet: value));
        // Load children
        return await api.getComments(state.tweetId).then((value) => emit(state.copyWith(status: TweetStatus.success, children: value.items)));
      })
        .onError((error, stackTrace) => emit(state.copyWith(status: TweetStatus.error)));
  }
}
