import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/BlocObserver.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:loaner/src/blocs/employee/bloc/employee_bloc.dart';
import 'package:loaner/src/blocs/loaner/bloc/loaner_bloc.dart';
import 'package:loaner/src/blocs/login/bloc/login_bloc.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/services/Urls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc()..add(AuthEventAppStart()),
          ),
          BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(_))
              // ..add(LoginEventStart()),
          ),
          BlocProvider<AppointmentBloc>(
            create: (_) => AppointmentBloc(),
          ),
          BlocProvider<LoanerBloc>(
            create: (_) => LoanerBloc(),
          ),
           BlocProvider<EmployeeBloc>(
            create: (_) => EmployeeBloc(),
          ),
        ],
        child: MyApp(),
      ));
    },
    blocObserver: SimpleBlocObserver(),
  );
}
