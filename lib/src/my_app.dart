import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/pages/login/login_page.dart';
import 'package:loaner/src/pages/splash/splash_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DialogCustom.dart';
import 'package:logger/logger.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

final logger = Logger(
  printer: PrettyPrinter(),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    if (kReleaseMode) {
      Logger.level = Level.nothing;
    } else {
      Logger.level = Level.debug;
    }

    var _route = <String, WidgetBuilder>{
      Constants.HOME_ROUTE: (context) => HomePage(),
      Constants.LOGIN_ROUTE: (context) => LoginPage(),
    };
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: BotToastInit(),
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  fontFamily: Constants.APP_FONT,
                  scaffoldBackgroundColor: Colors.white),
              home: Container(color: AppColors.COLOR_WHITE),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.APP_NAME,
            builder: BotToastInit(),
            theme: ThemeData(
                primarySwatch: AppColors.COLOR_PRIMARY_SWATCH,
                fontFamily: Constants.APP_FONT,
                scaffoldBackgroundColor: AppColors.COLOR_SWATCH),
            routes: _route,
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                BotToast.closeAllLoading();

                if (state is AuthenticationUnauthenticated) {
                  if (state.showAlert) {
                    state.showAlert = false;
                    WidgetsBinding.instance
                        ?.addPostFrameCallback((_) => dialogCustom(
                              context: context,
                              title: Constants.TEXT_FAILED,
                              content: state.message,
                            ));
                  }
                  return LoginPage();
                }

                if (state is AuthenticationAuthenticated) {
                  return SplashPage(isSupplier: true);
                }

                return LoginPage();
              },
            ),
          );
        });
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
