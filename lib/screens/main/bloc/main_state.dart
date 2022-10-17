part of 'main_bloc.dart';

enum AppStatus { notLogged, loading, logged, error }

class AppState extends Equatable {
  final AppStatus status;
  final String code;
  final String errorMessage;
  final String id;
  final String name;
  final String email;

  const AppState({
    this.status = AppStatus.notLogged,
    this.code = "",
    this.errorMessage = "",
    this.id = "",
    this.name = "",
    this.email = "",
  });

  AppState copyWith({
    AppStatus? status,
    String? code,
    String? errorMessage,
    String? id,
    String? name,
    String? email,
  }) {
    return AppState(
      status: status ?? this.status,
      code: code ?? this.code,
      errorMessage: errorMessage ?? this.errorMessage,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, code, errorMessage, id, name, email];
}
