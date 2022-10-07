import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:mobile/api/api.dart';
import 'package:mobile/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.api,
    required this.callback,
  }) : super(const AuthState()) {
    on<AuthGotCode>(_onAuthGotCode);
  }

  NetworkApi api;
  Function callback;

  Future<void> _onAuthGotCode(AuthGotCode event, Emitter<AuthState> emit) async {
    // Get the code, then call the original method
    emit(state.copyWith(status: AuthStatus.loading));
    String url = "$tokenUrl&code=${event.code}";
    await http.post(Uri.parse(url), body: {}, headers: {'Content-Type': 'application/x-www-form-urlencoded'}).then((response) async {
      if (response.statusCode != 200) {
        emit(state.copyWith(status: AuthStatus.invalidToken));
        return;
      }
      final tokenData = json.decode(response.body);
      emit(state.copyWith(status: AuthStatus.success));
      callback(tokenData);
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: AuthStatus.invalidToken));
      return;
    });
  }
}
