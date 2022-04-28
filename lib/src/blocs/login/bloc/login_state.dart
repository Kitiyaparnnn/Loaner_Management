part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {}

class LoginStateFailure extends LoginState {
  final String error;

  LoginStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginStateInValid extends LoginState {
  final String errorUsernamePassword;

  const LoginStateInValid({this.errorUsernamePassword = ""});

  @override
  List<Object> get props => [errorUsernamePassword];

  @override
  String toString() =>
      'LoginInValid { errorUsernamePassword: $errorUsernamePassword}';
}

class LoginStateIsShowPassword extends LoginState {
  final bool isShow;

  LoginStateIsShowPassword({this.isShow = false});

  @override
  List<Object> get props => [isShow];

  @override
  String toString() => 'LoginIsShowPassword {showPassword: $isShow}';
}

class LoginStateIsRemember extends LoginState {
  final bool isRemember;

  LoginStateIsRemember({this.isRemember = false});

  @override
  List<Object> get props => [isRemember];

  @override
  String toString() => 'LoginIsRemember : $isRemember';
}

class LoginStateIsRememberToggle extends LoginState {
  final bool isRemember;

  LoginStateIsRememberToggle({required this.isRemember});

  @override
  List<Object> get props => [isRemember];

  @override
  String toString() => 'LoginIsRememberToggle : $isRemember';
}
