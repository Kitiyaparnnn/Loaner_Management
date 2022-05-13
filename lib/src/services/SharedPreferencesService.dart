import 'package:shared_preferences/shared_preferences.dart';
import '../models/login/LoginDataUserModel.dart';
import '../utils/PreferenceKey.dart';

class SharedPreferencesService {
  Future<void> preferenceSetIsLogin({required bool isLogin}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(PreferenceKey.isLogin, isLogin);
  }

  Future<void> preferenceClearDataUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.remove(PreferenceKey.isLogin);
    _prefs.remove(PreferenceKey.userId);
    _prefs.remove(PreferenceKey.fName);
    _prefs.remove(PreferenceKey.lName);
    _prefs.remove(PreferenceKey.depId);
    _prefs.remove(PreferenceKey.typeId);
    _prefs.remove(PreferenceKey.image);
  }

  Future<void> preferenceSetDataUser({required LoginDataUserModel user}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString(PreferenceKey.userId, user.userId.toString());
    _prefs.setString(PreferenceKey.fName, user.firstName.toString());
    _prefs.setString(PreferenceKey.lName, user.lastName.toString());
    _prefs.setString(PreferenceKey.depId, user.depId.toString());
    _prefs.setString(PreferenceKey.typeId, user.typeId.toString());
    _prefs.setString(PreferenceKey.image, user.image.toString());
  }

  Future<String> preferenceGetFullName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _fullName =
        '${_prefs.getString(PreferenceKey.fName)} ${_prefs.getString(PreferenceKey.lName)}';
    return _fullName;
  }

  Future<bool> preferenceGetIsLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(PreferenceKey.isLogin) ?? false;
  }

  Future<String> preferenceGetUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.userId) ?? '';
  }

  Future<String> preferenceGetDepId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.depId) ?? '';
  }

  Future<String> preferenceGetImage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.image) ?? '';
  }

  Future<String> preferenceGetType() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.typeId) ?? '';
  }

  Future<String> preferenceGetUsername() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.username) ?? '';
  }

  Future<void> preferenceSetUsername({required String username}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceKey.username, username);
  }

  Future<void> preferenceSetRememberUsername({required bool isRemember}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(PreferenceKey.isRemember, isRemember);
  }

  Future<bool> preferenceGetRememberUsername() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(PreferenceKey.isRemember) ?? false;
  }

}
