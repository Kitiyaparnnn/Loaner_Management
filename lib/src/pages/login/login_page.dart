import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:loaner/src/blocs/login/bloc/login_bloc.dart';
import 'package:loaner/src/models/login/LoginModel.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DialogCustom.dart';

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
        color: AppColors.COLOR_SWATCH,
        elevation: 0,
        child: const Text(
          "${Constants.CREATE_BY}",
          style: const TextStyle(color: AppColors.COLOR_LIGHT, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          BotToast.closeAllLoading();

                          if (state is LoginStateLoading) {
                            BotToast.showLoading();
                          }

                          if (state is LoginStateFailure ||
                              state is LoginStateInValid) {
                            isEnabledButtonLogin = true;
                            WidgetsBinding.instance!.addPostFrameCallback(
                              (_) => dialogCustom(
                                context: context,
                                title: Constants.TEXT_FAILED,
                                content: Constants.TEXT_LOGIN_FAILED,
                              ),
                            );
                          }
                        },
                      ),
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          BotToast.closeAllLoading();
                          if (state is AuthenticationUnauthenticated) {
                            isEnabledButtonLogin = true;
                          }
                        },
                      ),
                    ],
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        // _buildLogo(),
                        const SizedBox(height: 40),
                        _buildTitle(),
                        const SizedBox(height: 30),
                        _buildForm(context),
                      ],
                    ),
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
                fontSize: 35,
                color: AppColors.COLOR_BLACK,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            Constants.APP_SUBTITLE,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: AppColors.COLOR_LIGHT,
                letterSpacing: 0.15),
          ),
        ],
      );

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginStateIsRemember) {
                isRemember = state.isRemember;
              }

              if (state is LoginStateLoading) {
                isEnabledButtonLogin = false;
              }

              if (state is LoginStateLoaded) {
                isEnabledButtonLogin = true;
              }

              if (state is LoginStateIsRememberToggle) {
                isRemember = state.isRemember;
              }

              if (state is LoginStateIsShowPassword) {
                hidePassword = state.isShow;
              }

              return _buildInput();
            },
          ),
          const SizedBox(height: 30),
          _buildButtonLogin(context),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Form(
      key: _formKey,
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
          SizedBox(height: 15),
          _buildRemember()
        ],
      ),
    );
  }

  Widget _label(String text) => Container(
        padding: const EdgeInsets.only(left: 5, bottom: 5),
        child: Text(
          "$text",
          style: const TextStyle(
              color: AppColors.COLOR_BLACK,
              letterSpacing: 0.15,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
      );

  TextFormField _buildTextFormFieldUsername() {
    return TextFormField(
      style: const TextStyle(color: AppColors.COLOR_BLACK),
      controller: _controllerUsername,
      decoration:
          _inputDecoration(hintText: "ชื่อผู้ใช้", contextBloc: context),
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
      style: TextStyle(color: AppColors.COLOR_BLACK),
      decoration: _inputDecoration(
          hintText: "รหัสผ่าน", passwordInput: true, contextBloc: context),
      obscureText: !hidePassword,
      focusNode: passwordFocusNode,
      onSaved: (value) {
        loginData.password = value;
      },
      onFieldSubmitted: (String value) {
        _formKey.currentState!.save();
        BlocProvider.of<LoginBloc>(context)
            .add(LoginEventOnPress(loginData: loginData));
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
      hintStyle: const TextStyle(color: AppColors.COLOR_LIGHT),
      fillColor: AppColors.COLOR_WHITE,
      filled: true,
      hintText: '$hintText',
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: const BorderSide(
          color: AppColors.COLOR_PRIMARY,
          width: 2,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: const BorderSide(
          color: AppColors.COLOR_GREY,
          width: 2.0,
        ),
      ),
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
      ),
      suffixIcon: passwordInput
          ? Padding(
              padding: EdgeInsetsDirectional.zero,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginBloc>(contextBloc).add(
                      LoginEventIsShowPasswordToggle(isShow: hidePassword));
                },
                child: Icon(
                  hidePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.COLOR_BLACK,
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _buildButtonLogin(BuildContext context) =>
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(0.0),
            color: Colors.transparent,
            onPressed: isEnabledButtonLogin
                ? () async {
                    _formKey.currentState!.save();
                    loginData.isRemember = isRemember;
                    // BlocProvider.of<LoginBloc>(context)
                    //     .add(LoginEventOnPress(loginData: loginData));

                    if (loginData.username == 'supplier') {
                      isSupplier = true;
                    } else {
                      isSupplier = false;
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.COLOR_PRIMARY,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              constraints: BoxConstraints(minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                "เข้าสู่ระบบ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 0.15,
                ),
              ),
            ),
          );
        },
      );

  Widget _buildRemember() {
    return Container(
      child: Container(
        child: Row(
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    activeColor: AppColors.COLOR_PRIMARY,
                    value: isRemember,
                    onChanged: (value) {
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginEventIsRememberToggle(isRemember: isRemember));
                    },
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "จดจำฉันไว้",
                  style: TextStyle(
                      color: AppColors.COLOR_BLACK,
                      fontSize: 16,
                      letterSpacing: 0.15),
                )
              ],
            ),
            Spacer(),
            Text("ลืมรหัสผ่าน?",
                style: TextStyle(
                  color: AppColors.COLOR_LIGHT,
                  fontSize: 16,
                ))
          ],
        ),
      ),
    );
  }
}
