import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loaner/src/models/login/LoginModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/AuthenticationService.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _authService = AuthenticationService();
  final _preferencesService = SharedPreferencesService();

  AuthenticationBloc() : super(AuthenticationUnauthenticated()) {
    on<AuthEventAppStart>(_mapAuthEventAppStartToState);
    on<AuthEventLoggedIn>(_mapAuthEventLoggedInToState);
    on<AuthEventLoggedOut>(_mapLoggedOutToState);
  }

  _mapAuthEventAppStartToState(AuthEventAppStart event, Emitter emit) async {
    final bool isLogin = await _preferencesService.preferenceGetIsLogin();
    if (isLogin) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  _mapAuthEventLoggedInToState(AuthEventLoggedIn event, Emitter emit) async {
    emit(AuthenticationLoading());
    try {
      final bool _result = await _authService.login(dataLogin: event.user);
      if (_result) {
        emit(AuthenticationAuthenticated());
      } else {
        String _message = Constants.TEXT_LOGIN_FAILED;
        emit(AuthenticationUnauthenticated(showAlert: true, message: _message));
      }
    } on TimeoutException {
      String _message = "Please check your internet connection.";
      emit(AuthenticationUnauthenticated(showAlert: true, message: _message));
    } on AuthenticationException catch (e) {
      String _message = e.message;
      emit(AuthenticationUnauthenticated(showAlert: true, message: _message));
    }
  }

  _mapLoggedOutToState(AuthEventLoggedOut event, Emitter emit) async {
    emit(AuthenticationLoading());
    await _authService.logout();
    emit(AuthenticationUnauthenticated(showAlert: false));
  }
}
