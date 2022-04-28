part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable{
    const AuthenticationState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationFirstLogin extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {
  bool showAlert;
  final String message;

  AuthenticationUnauthenticated({this.showAlert = false, this.message = ""});

  @override
  List<Object> get props => [showAlert, message];

  @override
  String toString() => 'AuthenticationUnauthenticated { showAlert: $showAlert, message: $message}';
}
