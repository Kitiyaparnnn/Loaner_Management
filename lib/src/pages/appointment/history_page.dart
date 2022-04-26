import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/InputDecorationDate.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isCompleted = false;
  List<AppointmentData> appointmentsData = [
    AppointmentData(
        hospitalName: "โรงพยาบาล ก",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[0]),
    AppointmentData(
        hospitalName: "โรงพยาบาล ก",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[1])
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

  AppointmentData? appointments;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  
  Widget _buildHistory() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: buildDropdown(
                    _controllerStatus, Constants.status, "สภานะนัดหมาย"),
              ),
              Icon(Icons.search_outlined)
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: buildDropdown(
                    _controllerHospitalName, Constants.hos, "โรงพยาบาล"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: InkWell(
                  onTap: () {
                    _datePickerShow(_controllerAppDate);
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: _controllerAppDate,
                    decoration: inputDecorationDate(hintText: "วันที่นัดหมาย", isDate: true,),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          
        ],
      ),
    );
  }
}