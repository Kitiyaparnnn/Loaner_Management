import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:loaner/src/pages/login/login_page.dart';
import 'package:loaner/src/utils/Constants.dart';

void askForConfirmToLogout(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(Constants.TEXT_LOGOUT),
        content: Text(Constants.TEXT_LOGOUT_MESSAGE),
        actions: <Widget>[
          TextButton(
            child: Text(
              Constants.TEXT_CANCEL,
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
          TextButton(
            child: Text(
              Constants.TEXT_CONFIRM,
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthEventLoggedOut());
            },
          ),
        ],
      );
    },
  );
}
