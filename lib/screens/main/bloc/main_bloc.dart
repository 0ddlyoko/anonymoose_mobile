import 'package:dio/dio.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/api/auth_request_interceptor.dart';
import 'package:mobile/models/profile/profile.dart';
import 'package:mobile/models/tweet/tweet.dart';

part 'main_event.dart';
part 'main_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.api,
  }) : super(const AppState()) {
    on<UserLogged>(_onUserLogged);
  }

  NetworkApi api;

  Future<void> _onUserLogged(UserLogged event, Emitter<AppState> emit) async {
    print("User logged");
    emit(state.copyWith(status: AppStatus.loading));
    api.dio.interceptors.add(AuthInterceptor(event.idToken));
    return api.getProfile().then((value) {
      return handleProfile(value.data, event.idToken);
    }).catchError((error, stacktrace) async {
      // Doing that (the DioError) is soooooo ugly, but badly for now it's the only way to make it working.
      // For now, we'll still use it, but later (for other projects), we'll fix that.
      switch (error.runtimeType) {
        case DioError:
          final res = (error as DioError).response;
          switch (res?.statusCode) {
            case 400:
              return emit(state.copyWith(status: AppStatus.error, errorMessage: "Multiple account with same email exists! Please contact an administrator"));
            case 404:
              // Create the profile
              return await api.createProfile().then((value) {
                return handleProfile(value.data, event.idToken);
              }).catchError((error) {
                // TODO Check if it's an error 409
                return emit(state.copyWith(status: AppStatus.error, errorMessage: "Same username/email already exist for this user. Please choose a new one"));
              });
            default:
              return emit(state.copyWith(status: AppStatus.error, errorMessage: "An error has occurred, please retry"));
          }
      }
      emit(state.copyWith(status: AppStatus.loading));
      print("OK");
      print(error);
      print("KO");
    });
  }

  Future<void> handleProfile(Profile profile, dynamic code) async {
    print("id: ${profile.id}, name: ${profile.name}, email: ${profile.email}");
    emit(state.copyWith(status: AppStatus.logged, code: code, id: profile.id, name: profile.name, email: profile.email));
    return api.getTweets().then((value) {
      return emit(state.copyWith(status: AppStatus.done, tweets: value.data.items));
    }).catchError((error, stacktrace) {
      return emit(state.copyWith(status: AppStatus.error, errorMessage: "An error has occurred while loading tweets, please retry"));
    });
  }
}
