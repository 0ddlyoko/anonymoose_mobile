part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AuthGotCode extends AuthEvent {
  AuthGotCode(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}
