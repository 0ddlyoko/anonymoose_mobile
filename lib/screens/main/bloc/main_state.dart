part of 'main_bloc.dart';

enum AppStatus { notLogged, loading, logged, done, error }

class AppState extends Equatable {
  final AppStatus status;
  final String code;
  final String errorMessage;
  final String id;
  final String name;
  final String email;
  final List<Tweet> tweets;

  const AppState({
    this.status = AppStatus.notLogged,
    this.code = "",
    this.errorMessage = "",
    this.id = "",
    this.name = "",
    this.email = "",
    this.tweets = const [],
  });

  AppState copyWith({
    AppStatus? status,
    String? code,
    String? errorMessage,
    String? id,
    String? name,
    String? email,
    List<Tweet>? tweets,
  }) {
    return AppState(
      status: status ?? this.status,
      code: code ?? this.code,
      errorMessage: errorMessage ?? this.errorMessage,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      tweets: tweets ?? this.tweets,
    );
  }

  @override
  List<Object?> get props => [status, code, errorMessage, id, name, email, tweets];
}
