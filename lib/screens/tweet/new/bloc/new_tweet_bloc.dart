import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/models/tweet/create_tweet.dart';

part 'new_tweet_event.dart';
part 'new_tweet_state.dart';

class NewTweetBloc extends Bloc<NewTweetEvent, NewTweetState> {
  NewTweetBloc({
    required this.api,
    required String tweetId,
  }) : super(NewTweetState(
    tweetId: tweetId,
  )) {
    on<NewTweetDisplayChanged>(_onTweetDisplayChanged);
    on<NewTweetTitleChanged>(_onTweetTitleChanged);
    on<NewTweetDescriptionChanged>(_onTweetDescriptionChanged);
    on<NewTweetSubmitted>(_onNewTweetSubmitted);
  }

  final NetworkApi api;

  void _onTweetDisplayChanged(NewTweetDisplayChanged event, Emitter<NewTweetState> emit) {
    emit(state.copyWith(display: event.display));
  }

  void _onTweetTitleChanged(NewTweetTitleChanged event, Emitter<NewTweetState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onTweetDescriptionChanged(NewTweetDescriptionChanged event, Emitter<NewTweetState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _onNewTweetSubmitted(NewTweetSubmitted event, Emitter<NewTweetState> emit) async {
    emit(state.copyWith(status: NewTweetStatus.sending));
    if (state.tweetId != null) {
      return await api.postComment(state.tweetId!, CreateTweetComment(
        title: state.title,
        text: state.description,
        author: CreateTweetAuthor(hidden: !state.display),
      )).then((value) {
        emit(state.copyWith(status: NewTweetStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: NewTweetStatus.error));
      });
    } else {
      return await api.createTweet(CreateTweet(
        title: state.title,
        text: state.description,
        author: CreateTweetAuthor(hidden: !state.display),
      )).then((value) {
        emit(state.copyWith(status: NewTweetStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: NewTweetStatus.error));
      });
    }
  }
}
