import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

class AppointmentPage extends StatefulWidget {
  AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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

  @override
  void initState() {
    super.initState();
  }

  AppointmentData? appointments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom: const TabBar(
              indicatorColor: AppColors.COLOR_WHITE,
              indicatorWeight: 5.0,
              tabs: [
                Tab(
                  text: Constants.APPOINTMENT_TITLE,
                ),
                Tab(text: Constants.HISTORY_TITLE),
              ],
            )),
            body: TabBarView(
              children: [_buildAppointment(context), _buildHistory()],
            )),
      ),
    );
  }

  Widget _buildAppointment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          separatorBuilder: ((context, index) => Divider(
                color: AppColors.COLOR_GREY,
                thickness: 2.0,
              )),
          itemCount: appointmentsData.length,
          itemBuilder: ((context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(appointmentsData[index].hospitalName!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Text(
                          appointmentsData[index].status!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text("หน่วยงาน: ${appointmentsData[index].organizeName}"),
                    Row(
                      children: [
                        Text(
                            "วันที่นัดหมาย: ${appointmentsData[index].appDate}"),
                        SizedBox(width: 10),
                        Text("เวลา: ${appointmentsData[index].appTime}")
                      ],
                    )
                  ])),
        ),
      ),
    );
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
                child: _buildDropdown(
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
                child: _buildDropdown(
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
                    decoration: inputDecoration(hintText: "วันที่นัดหมาย"),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExpansionTile(
              controlAffinity: ListTileControlAffinity.platform,
              collapsedTextColor: Colors.white,
              collapsedBackgroundColor: Colors.lightBlueAccent,
              childrenPadding: EdgeInsets.only(bottom: 10),
              collapsedIconColor: Colors.white,
              iconColor: Colors.lightBlueAccent,
              initiallyExpanded: isCompleted,
              onExpansionChanged: (value) {
                isCompleted = value;
                setState(() {});
              },
              title: Text(
                "นัดหมายเสร็จสิ้น",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.lightBlueAccent : Colors.white,
                ),
              ),
              children: appointmentsData.isEmpty
                  ? [_eventEmpty()]
                  : _buildList(data: appointmentsData),
            ),
          )
        ],
      ),
    );
  }

  DropdownButtonFormField _buildDropdown(
      TextEditingController form, List<String> items, String hintText) {
    return DropdownButtonFormField(
      decoration: selectDecoration(hintText: hintText),
      icon: Icon(Icons.expand_more_rounded),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        form.text = value;
        setState(() {});
      },
    );
  }

  Widget _eventEmpty() => Container(
        padding: EdgeInsets.all(20),
        child: Text(
          "Event not found",
          style: TextStyle(color: Colors.grey),
        ),
      );

  List<Widget> _buildList({required List<AppointmentData> data}) {
    List<Widget> _widget = [];
    List<AppointmentData> appoint = [];

    if (data.length > 0) {
      data.map((e) => {_widget.add(_buildDetail(appoint: e))}).toList();
    } else {
      _widget.add(_eventEmpty());
    }

    return _widget;
  }

  Widget _buildDetail({required AppointmentData appoint}) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(appoint.hospitalName!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Spacer(),
                Text(
                  appoint.status!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text("หน่วยงาน: ${appoint.organizeName}"),
            Row(
              children: [
                Text("วันที่นัดหมาย: ${appoint.appDate}"),
                SizedBox(width: 10),
                Text("เวลา: ${appoint.appTime}")
              ],
            ),
            Divider(
              color: AppColors.COLOR_GREY,
              thickness: 2.0,
            )
          ],
        ),
      );
}
