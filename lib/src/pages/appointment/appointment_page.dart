import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/appointment/AppointmentModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/history_page.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AppointmentCard.dart';
import 'package:loaner/src/utils/AppointmentCard_cssd.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

class AppointmentPage extends StatefulWidget {
  AppointmentPage({required this.isSupplier});
  bool isSupplier;
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List<AppointmentModel> appointments = [];

  @override
  void initState() {
    // widget.isSupplier
    //     ?
    context.read<AppointmentBloc>().add(AppointmentGetAll());
    // : context
    //     .read<AppointmentBloc>()
    //     .add(AppointmentGetByStatus(status: "2"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.COLOR_SWATCH,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.COLOR_BLACK),
          onPressed: () => Navigator.popUntil(
              context, (Route<dynamic> route) => route.isFirst),
        ),
        title: Column(
          children: [
            Text(
              Constants.APPOINTMENT_TITLE,
              style: TextStyle(
                color: AppColors.COLOR_BLACK,
              ),
            )
          ],
        ),
        actions: [
          widget.isSupplier
              ? IconButton(
                  icon: Icon(
                    Icons.history_outlined,
                    color: AppColors.COLOR_BLACK,
                    size: 30,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryPage())).then((value) =>
                      context.read<AppointmentBloc>().add(AppointmentGetAll())))
              : SizedBox(
                  width: 10,
                ),
        ],
        centerTitle: true,
      ),
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
      ),
    );
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
    List<Color> _color = object[index].status == "1"
        ? [AppColors.COLOR_PRIMARY, AppColors.COLOR_BLUE]
        : object[index].status == "2"
            ? [AppColors.COLOR_YELLOW2, AppColors.COLOR_YELLOW]
            : [AppColors.COLOR_GREEN2, AppColors.COLOR_GREEN];

    return widget.isSupplier
        ? appointmentCard(
            color: _color, object: object[index], context: context)
        : appointmentCard_cssd(
            color: _color,
            object: object[index],
            context: context,
            isCompleted: true);
  }
}
