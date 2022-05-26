import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/appointment/AppointmentModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AppointmentCard_cssd.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/MyAppBar.dart';

class ConfirmAppointmentPage extends StatefulWidget {
  ConfirmAppointmentPage({Key? key}) : super(key: key);

  @override
  State<ConfirmAppointmentPage> createState() => _ConfirmAppointmentPageState();
}

class _ConfirmAppointmentPageState extends State<ConfirmAppointmentPage> {
  List<AppointmentModel> appointments = [];
  @override
  void initState() {
    context.read<AppointmentBloc>().add(AppointmentGetByStatus(status: "1",limit:""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            myAppBar(title: Constants.CONFIRM_APPOINT_TITLE, context: context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  _appointmentList(),
                ],
              ),
            ),
          ),
        ));
  }

  _appointmentList() {
    // print(items.length);
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentStateGetAll) {
          appointments = state.data;
        }
        return Expanded(
          child: appointments.length == 0
              ? Center(
                  child: Text(Constants.TEXT_DATA_NOT_FOUND),
                )
              : ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: ((context, index) =>
                      _mapList(appointments, index)),
                ),
        );
      },
    );
  }

  _mapList(List<AppointmentModel> object, int index) {
    List<Color> _color = [AppColors.COLOR_PRIMARY, AppColors.COLOR_BLUE];

    return appointmentCard_cssd(
        color: _color,
        object: object[index],
        context: context,
        isCompleted: false);
  }
}
