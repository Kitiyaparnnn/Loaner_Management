import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
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
  List<AppointmentDataModel> appointments = [
    AppointmentDataModel(
        companyName: "บริษัท ก",
        empName: "0",
        cssdName: "สายสาคร นครยานพ",
        organizeName: "0",
        docName: "0",
        depName: "0",
        patientName: "มานาบี ชีวันนา",
        useDate: "13-02-2022",
        useTime: "12:00",
        appDate: "23-02-2022",
        appTime: "11:00",
        status: "1",
        hospitalName: "0",
        loaners: [
          LoanerModel(
              name: 'LoanerA',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 3,
              note: ''),
          LoanerModel(
              name: 'LoanerB',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: ''),
          LoanerModel(
              name: 'LoanerC',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: ''),
          LoanerModel(
              name: 'LoanerD',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: ''),
          LoanerModel(
              name: 'LoanerE',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: ''),
          LoanerModel(
              name: 'LoanerF',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: '')
        ]),
    AppointmentDataModel(
        companyName: "บริษัท 123",
        empName: "1",
        cssdName: "สายสาคร นครยานพ",
        organizeName: "1",
        docName: "1",
        depName: "1",
        patientName: "มานาบี ชีวันนา",
        useDate: "13-02-2022",
        useTime: "12:00",
        appDate: "23-02-2022",
        appTime: "11:00",
        status: "1",
        hospitalName: "1",
        loaners: [
          LoanerModel(
              name: 'LoanerX',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 3,
              note: ''),
          LoanerModel(
              name: 'LoanerY',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: ''),
          LoanerModel(
              name: 'LoanerZ',
              detail:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
              rent: 2,
              note: '')
        ]),
  ];
  @override
  void initState() {
    context.read<AppointmentBloc>().add(AppointmentGetByStatus(status: "1"));
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
          // appointments = state.data;
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

  _mapList(List<AppointmentDataModel> object, int index) {
    List<Color> _color = [AppColors.COLOR_YELLOW2, AppColors.COLOR_YELLOW];

    return appointmentCard_cssd(
        color: _color,
        object: object[index],
        context: context,
        isCompleted: false);
  }
}
