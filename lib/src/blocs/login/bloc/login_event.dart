part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEventStart extends LoginEvent {}

class LoginEventOnPress extends LoginEvent {
  final LoginModel loginData;

  LoginEventOnPress({required this.loginData});

  @override
  List<Object> get props => [loginData];
}

class LoginEventIsShowPasswordToggle extends LoginEvent {
  final bool isShow;

  LoginEventIsShowPasswordToggle({this.isShow = false});

  @override
  List<Object> get props => [isShow];

  @override
  String toString() => 'LoginIsShowPasswordToggle { isShow: $isShow }';
}

class LoginEventIsRememberToggle extends LoginEvent{
  final bool isRemember;

  LoginEventIsRememberToggle({this.isRemember = false});

  @override
  List<Object> get props => [isRemember];

  @override
  String toString() => 'LoginRememberClick { isRemember: $isRemember }';
}
