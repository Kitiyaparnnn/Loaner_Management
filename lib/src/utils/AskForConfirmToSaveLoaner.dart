import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/blocs/loaner/bloc/loaner_bloc.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/models/loaner/LoanerDataModel.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/pages/login/login_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

void askForConfirmToSaveLoaner(
    {required BuildContext context, required LoanerDataModel loaner}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Icon(Icons.save_outlined),
        content: Text(Constants.TEXT_SAVE_MESSAGE),
        actions: <Widget>[
          TextButton(
            child: Text(
              Constants.TEXT_CANCEL,
              style: TextStyle(color: AppColors.COLOR_LIGHT, fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
          TextButton(
            child: Text(
              Constants.TEXT_CONFIRM,
              style: TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 16),
            ),
            onPressed: () {
              context.read<LoanerBloc>().add(LoanerCreate(loaner: loaner));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoanerPage(
                          isFillForm: false,
                          selectedLoaner: [],
                          isEdit: false)));
            },
          ),
        ],
      );
    },
  );
}
