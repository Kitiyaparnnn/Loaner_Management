import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AppointmentCard.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/InputDecorationDate.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/TextFormFieldInput.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isCompleted = false;
  List<AppointmentData> appointments = [
    AppointmentData(
        hospitalName: "โรงพยาบาล ก",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[3]),
    AppointmentData(
        hospitalName: "โรงพยาบาล ก",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[4])
  ];

  TextEditingController editingController = TextEditingController();
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
      setState(() {});
    }
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
    return Form(
      // key: _formKey,
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdown(
                      _controllerStatus, Constants.status, "สถานะการนัดหมาย"),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: InkWell(
                onTap: () {
                  _datePickerShow(_controllerAppDate);
                },
                child: TextFormField(
                  enabled: false,
                  controller: _controllerAppDate,
                  decoration: inputDecorationDate(
                      hintText: "วันที่ขอใช้", isDate: true),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDropdown(_controllerStatus, Constants.hos, "โรงพยาบาล"),
          ],
        )
      ]),
    );
  }

  _appointmentList() {
    // print(items.length);
    return Expanded(
      child: appointments.length == 0
          ? Center(
              child: Text(Constants.TEXT_DATA_NOT_FOUND),
            )
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: ((context, index) => _mapList(appointments, index)),
            ),
    );
  }

  _mapList(List<AppointmentData> object, int index) {
    List<Color> _color = object[index].status! == Constants.status[3]
        ? [AppColors.COLOR_GREEN2, AppColors.COLOR_GREEN]
        : [AppColors.COLOR_YELLOW2, AppColors.COLOR_YELLOW];

    return appointmentCard(
        color: _color, object: object[index], context: context);
  }
}
