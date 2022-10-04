import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobile/api/api.dart';

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
}
