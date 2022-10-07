part of 'auth_bloc.dart';

enum AuthStatus { initial, invalidToken, loading, success }

class AuthState extends Equatable {
  final AuthStatus status;
  final String code;

  const AuthState({
    this.status = AuthStatus.initial,
    this.code = "",
  });

  AuthState copyWith({
    AuthStatus? status,
    String? code,
  }) {
    return AuthState(
      status: status ?? this.status,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [status, code];
}
