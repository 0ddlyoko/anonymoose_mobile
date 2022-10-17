part of 'main_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {}

abstract class UserEvent extends AppEvent {}

class UserLogged extends UserEvent {
  UserLogged(this.idToken);

  final String idToken;

  @override
  List<Object?> get props => [idToken];
}
