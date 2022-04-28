part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthEventAppStart extends AuthenticationEvent {}

class AuthEventLoggedIn extends AuthenticationEvent {
  final LoginModel user;

  const AuthEventLoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}


class AuthEventLoggedOut extends AuthenticationEvent {}