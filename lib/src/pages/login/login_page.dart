// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loaner/src/models/login/LoginModel.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool hidePassword = false;
  bool isEnabledButtonLogin = true;
  final loginData = LoginModel();
  var _formKey = GlobalKey<FormState>();

  TextEditingController _controllerUsername =
      new TextEditingController(text: "");
  TextEditingController _controllerPassword =
      new TextEditingController(text: "");

  FocusNode passwordFocusNode = FocusNode();

  bool isRemember = false;
  bool loading = false;
  bool isSupplier = true;

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  Future getUsername() async {
    SharedPreferencesService _prefs = SharedPreferencesService();
    _controllerUsername.text = await _prefs.preferenceGetUsername();

    isRemember = await _prefs.preferenceGetRememberUsername();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: const Text(
          "${Constants.CREATE_BY}",
          style: const TextStyle(color: AppColors.COLOR_GREY, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.COLOR_PINK
              // image: DecorationImage(
              //     image: AssetImage('${Constants.IMAGE_DIR}/bg_login.png'),
              //     fit: BoxFit.cover),
              ),
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      // _buildLogo(),
                      const SizedBox(height: 40),
                      _buildTitle(),
                      const SizedBox(height: 30),
                      _buildForm(context),
                      const SizedBox(height: 50),
                      // _loading()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() => Container(
        child: Image.asset(
          '${Constants.IMAGE_DIR}/logo.png',
          width: 210,
        ),
      );

  Widget _buildTitle() => Column(
        children: [
          const Text(
            Constants.APP_NAME,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: AppColors.COLOR_DARK,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            "Log in with your username and password.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: AppColors.COLOR_GREY, letterSpacing: 0.15),
          ),
        ],
      );

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          _buildInput(),
          const SizedBox(height: 30),
          _buildButtonLogin(context),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("ชื่อผู้ใช้"),
                _buildTextFormFieldUsername(),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("รหัสผ่าน"),
                _buildTextFormFieldPassword(context),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Container(
        padding: const EdgeInsets.only(left: 5, bottom: 5),
        child: Text(
          "$text",
          style: const TextStyle(
              color: AppColors.COLOR_DARK,
              letterSpacing: 0.15,
              fontWeight: FontWeight.w500),
        ),
      );

  TextFormField _buildTextFormFieldUsername() {
    return TextFormField(
      style: const TextStyle(color: AppColors.COLOR_DARK),
      controller: _controllerUsername,
      decoration: _inputDecoration(hintText: "username", contextBloc: context),
      onSaved: (value) {
        loginData.username = value;
      },
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
    );
  }

  TextFormField _buildTextFormFieldPassword(BuildContext context) {
    return TextFormField(
      controller: _controllerPassword,
      style: TextStyle(color: AppColors.COLOR_DARK),
      decoration: _inputDecoration(
          hintText: "Insert your password here",
          passwordInput: true,
          contextBloc: context),
      obscureText: !hidePassword,
      focusNode: passwordFocusNode,
      onSaved: (value) {
        loginData.password = value;
      },
      onFieldSubmitted: (String value) {
        _formKey.currentState!.save();
        // BlocProvider.of<LoginBloc>(context).add(LoginEventOnPress(loginData: loginData));
      },
    );
  }

  InputDecoration _inputDecoration({
    bool passwordInput = false,
    required String hintText,
    required BuildContext contextBloc,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 15),
      hintStyle: const TextStyle(color: AppColors.COLOR_GREY),
      fillColor: AppColors.COLOR_WHITE,
      filled: true,
      hintText: '$hintText',
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: const BorderSide(
          color: AppColors.COLOR_PRIMARY,
          width: 2,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      prefixIcon: Padding(
          padding: EdgeInsetsDirectional.zero,
          child: Icon(
            passwordInput ? Icons.lock_outline : Icons.person_outlined,
          )),
      suffixIcon: passwordInput
          ? Padding(
              padding: EdgeInsetsDirectional.zero,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                  // BlocProvider.of<LoginBloc>(contextBloc).add(LoginEventIsShowPasswordToggle(isShow: hidePassword));
                },
                child: Icon(
                  hidePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.COLOR_GREY,
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _buildButtonLogin(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(0.0),
        color: Colors.transparent,
        onPressed: isEnabledButtonLogin
            ? () async {
                _formKey.currentState!.save();
                loginData.isRemember = isRemember;
                // BlocProvider.of<LoginBloc>(context)
                //     .add(LoginEventOnPress(loginData: loginData));
                // loading = !loading;
                // setState(() {});
                // await Future.delayed(Duration(seconds: 5));
                if (loginData.username == 'supplier') {
                  isSupplier = true;
                } else {
                  isSupplier = false;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              isSupplier: isSupplier,
                            )));
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.COLOR_PRIMARY,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          constraints: BoxConstraints(minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            "เข้าสู่ระบบ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _loading() {
    return Container(
      color: Colors.transparent,
      child: loading
          ? Center(
              child: Column(
                children: [
                  Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(
                          color: AppColors.COLOR_SECONDARY),
                  SizedBox(
                    height: 5,
                  ),
                  Text(Constants.LOADING_TEXT,
                      style: TextStyle(color: AppColors.COLOR_GREY))
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
