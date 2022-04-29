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
    _prefs.remove(PreferenceKey.empCode);
    _prefs.remove(PreferenceKey.fName);
    _prefs.remove(PreferenceKey.fName);
    _prefs.remove(PreferenceKey.depId);
    _prefs.remove(PreferenceKey.depName);
    _prefs.remove(PreferenceKey.companyName);
    _prefs.remove(PreferenceKey.role);
  }

  Future<void> preferenceSetDataUser({required LoginDataUserModel user}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString(PreferenceKey.userId, user.userId.toString());

    _prefs.setString(PreferenceKey.empCode, user.empCode.toString());
    _prefs.setString(PreferenceKey.fName, user.firstName.toString());
    _prefs.setString(PreferenceKey.lName, user.lastName.toString());

    _prefs.setString(PreferenceKey.depId, user.depId.toString());
    _prefs.setString(PreferenceKey.depName, user.depName.toString());
    _prefs.setString(PreferenceKey.companyName, user.companyName.toString());
    _prefs.setString(PreferenceKey.role, user.role.toString());
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

  Future<String> preferenceGetCompany() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.companyName) ?? '';
  }

  Future<String> preferenceGetRole() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.role) ?? '';
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

  Future<void> preferenceSetBaseApiUrl({required String url}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceKey.baseApiUrl, url);
  }

  Future<String> preferenceGetBaseApiUrl() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceKey.baseApiUrl) ?? "";
  }

  Future<void> preferenceSetShowPM({required bool isShow}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(PreferenceKey.showPM, isShow);
  }

  Future<bool> preferenceGetShowPM() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(PreferenceKey.showPM) ?? false;
  }
}
