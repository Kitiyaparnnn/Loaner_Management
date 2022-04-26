import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/history_page.dart';
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
  List<AppointmentData> appointments = [
    AppointmentData(
        hospitalName: "โรงพยาบาล ก",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[2]),
    AppointmentData(
        hospitalName: "โรงพยาบาล ง",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[1]),
    AppointmentData(
        hospitalName: "โรงพยาบาล ง",
        organizeName: "บริษัท ก",
        appDate: "22-04-2022",
        appTime: "12:00",
        status: Constants.status[0])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.COLOR_SWATCH,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.COLOR_BLACK),
          onPressed: () => Navigator.of(context).pop(),
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
          IconButton(
              icon: Icon(
                Icons.history_outlined,
                color: AppColors.COLOR_BLACK,
                size: 30,
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryPage()))),
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
    List<Color> _color = object[index].status! == Constants.status[0]
        ? [AppColors.COLOR_PRIMARY, AppColors.COLOR_BLUE]
        : object[index].status! == Constants.status[1]
            ? [AppColors.COLOR_YELLOW2, AppColors.COLOR_YELLOW]
            : [AppColors.COLOR_GREEN2, AppColors.COLOR_GREEN];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: _color[0],
      elevation: 0.5,
      child: InkWell(
          child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.COLOR_WHITE,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(object[index].hospitalName!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Container(
                      decoration: BoxDecoration(
                          color: _color[1],
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text("o " + object[index].status!,
                            style: TextStyle(fontSize: 12, color: _color[0])),
                      ))
                ],
              ),
              Row(
                children: [
                  Text("หน่วยงาน : ",
                      style: TextStyle(
                          fontSize: 14, color: AppColors.COLOR_LIGHT)),
                  Text(object[index].organizeName!,
                      style:
                          TextStyle(fontSize: 14, color: AppColors.COLOR_BLACK))
                ],
              ),
              Row(
                children: [
                  Text("วันที่นัดหมาย : ",
                      style: TextStyle(
                          fontSize: 14, color: AppColors.COLOR_LIGHT)),
                  Text(object[index].appDate!,
                      style: TextStyle(
                          fontSize: 14, color: AppColors.COLOR_BLACK)),
                  SizedBox(width: 10),
                  Text("เวลา : ",
                      style: TextStyle(
                          fontSize: 14, color: AppColors.COLOR_LIGHT)),
                  Text(object[index].appTime! + " น.",
                      style:
                          TextStyle(fontSize: 14, color: AppColors.COLOR_BLACK))
                ],
              )
            ]),
          ),
        ),
      )),
    );
  }
}
