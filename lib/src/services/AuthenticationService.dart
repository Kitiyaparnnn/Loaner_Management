import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/login/LoginDataUserModel.dart';
import 'package:loaner/src/models/login/LoginModel.dart';
import 'package:loaner/src/services/Urls.dart';


import '../my_app.dart';
import 'SharedPreferencesService.dart';


class AuthenticationService {
  final _sharedPreferencesService = SharedPreferencesService();

  Future<bool> login({LoginModel? dataLogin}) async {
    try {
      
      final _url = Uri.parse(Urls.loginUrl);
      var _response;

      if (dataLogin == null) {
        throw AuthenticationException(message: 'Wrong username or password');
      }

      Map<String, dynamic> _body = {
        'username': dataLogin.username,
        'password': dataLogin.password,
      };

      _response = await http
          .post(_url,
        body: jsonEncode(_body),
      )
          .timeout(Duration(seconds: 3), onTimeout: () {
        throw AuthenticationException(message: 'You are not connected to internet');
      });

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);
        List<LoginDataUserModel> _userLogin = _jsonResponse.map((i) => LoginDataUserModel.fromJson(i)).toList();

        if (_userLogin.length > 0) {
          await _sharedPreferencesService.preferenceSetIsLogin(isLogin: true);
          await _sharedPreferencesService.preferenceSetDataUser(user: _userLogin[0]);

          if (dataLogin.isRemember) {
            await _sharedPreferencesService.preferenceSetRememberUsername(isRemember: true);
            await _sharedPreferencesService.preferenceSetUsername(username: dataLogin.username.toString());
          }

          loggerNoStack.w("logged in successfully");

          return true;
        }
      }
      loggerNoStack.e("logged in failed");
      return false;
    } on SocketException {
      throw AuthenticationException(message: 'You are not connected to internet');
    } on TimeoutException {
      throw AuthenticationException(message: 'You are not connected to internet');
    }
  }


  Future<void> logout() async {
    await _sharedPreferencesService.preferenceSetIsLogin(isLogin: false);
    await _sharedPreferencesService.preferenceClearDataUser();
    loggerNoStack.w("log out successfully");
    return await Future<void>.delayed(Duration(seconds: 1));
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
