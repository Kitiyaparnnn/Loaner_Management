import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/DropdownModel.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/appointment/AppointmentModel.dart';
import 'package:loaner/src/models/appointment/AppointmentSearchModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AppointmentCard.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/InputDecorationDate.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';
import 'package:loaner/src/utils/TextFormFieldInput.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final AppointmentSearchModel search = AppointmentSearchModel();

  List<AppointmentModel> appointments = [];

  TextEditingController _controllerStatus = new TextEditingController(text: "");
  TextEditingController _controllerAppDate =
      new TextEditingController(text: "");
  TextEditingController _controllerHospitalName =
      new TextEditingController(text: "");

  String currentDateSelectText =
      ConvertDateFormat.convertDateFormat(date: DateTime.now());
  DateTime currentDateSelect = DateTime.now();

  Future<void> _datePickerShow(TextEditingController date) async {
    DateTime? chooseDate = await showDatePicker(
      context: context,
      initialDate: currentDateSelect,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      helpText: "กรุณาเลือกวันที่",
      cancelText: Constants.TEXT_CANCEL,
      confirmText: Constants.TEXT_CONFIRM,
      fieldHintText: 'วัน/เดือน/ปี',
    );

    if (chooseDate != null) {
      currentDateSelect = chooseDate;
      date.text = ConvertDateFormat.convertDateFormat(date: chooseDate);
      validate();
    }
  }

  @override
  void initState() {
    context.read<AppointmentBloc>().add(AppointmentGetHospital());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: Constants.HISTORY_TITLE, context: context),
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
                _buildForm(),
                SizedBox(height: 10),
                _appointmentList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildForm() {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                    _controllerStatus, Constants.status, "สถานะการนัดหมาย"),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: InkWell(
              onTap: () {
                _datePickerShow(_controllerAppDate);
              },
              child: TextFormField(
                enabled: false,
                controller: _controllerAppDate,
                decoration: inputDecorationDate(
                    hintText: "วันที่นัดหมาย", isDate: true),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AppointmentBloc, AppointmentState>(
            builder: (context, state) {
              List<DropdownModel> hospital = [];
              if (state is AppointmentStateGetHospital) {
                hospital = state.data;
              }
              return buildDropdownInput(
                  _controllerHospitalName, hospital, "โรงพยาบาล");
            },
          ),
        ],
      )
    ]);
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

    return appointmentCard(
        color: _color, object: object[index], context: context);
  }

  validate() {
    search.status = _controllerStatus.text;
    search.hospital = _controllerHospitalName.text;
    search.date = _controllerAppDate.text;

    context.read<AppointmentBloc>().add(AppointmentGetBySearch(search: search));
  }

  DropdownButtonFormField _buildDropdown(
      TextEditingController form, Map<String, String> items, String hintText) {
    return DropdownButtonFormField(
      decoration: selectDecoration(hintText: hintText),
      icon: Icon(Icons.expand_more_rounded),
      items: items.keys.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(items[value]!),
        );
      }).toList(),
      onChanged: (value) {
        form.text = value;
        validate();
      },
    );
  }
}
