import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/pages/fill_appointment/fill_appointment_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/MyAppBar.dart';

class DetailAppointmentPage extends StatefulWidget {
  DetailAppointmentPage({Key? key}) : super(key: key);

  @override
  State<DetailAppointmentPage> createState() => _DetailAppointmentPageState();
}

class _DetailAppointmentPageState extends State<DetailAppointmentPage> {
  final AppointmentData appointment = AppointmentData(
      companyName: "บริษัท ก",
      empName: "นพกร มังกรใส",
      cssdName: "สายสาคร นครยานพ",
      organizeName: "หน่วยงาน ก",
      docName: "นพ.สวัสดี มีมาคร",
      depName: "หน่วยงาน ก",
      patientName: "มานาบี ชีวันนา",
      useDate: "13-02-2022",
      useTime: "12:00",
      appDate: "23-02-2022",
      appTime: "11:00",
      loaners: [
        LoanerModel(
            name: 'LoanerA',
            detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            rent: 3,
            note: ''),
        LoanerModel(
            name: 'LoanerB',
            detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            rent: 2,
            note: ''),
        LoanerModel(
            name: 'LoanerC',
            detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            rent: 2,
            note: ''),
        LoanerModel(
            name: 'LoanerD',
            detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            rent: 2,
            note: ''),
        LoanerModel(
            name: 'LoanerE',
            detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            rent: 2,
            note: ''),
        LoanerModel(
            name: 'LoanerF',
            detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            rent: 2,
            note: '')
      ]);

  final EmployeeDataModel employee = EmployeeDataModel(
      firstName: 'abcd',
      lastName: 'efgh',
      detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
      isTrained: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: Constants.DETAIL_APPOINT_TITLE, context: context),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                primary: AppColors.COLOR_PRIMARY),
            onPressed: () {
              try {
                appointment.status = Constants.status[2];
                setState(() {});
                logger.d(appointment.toJson());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentPage(
                              isSupplier: false,
                            )));
              } catch (e) {
                logger.e(e);
              }
            },
            child: Text("ยืนยันการนัดหมาย", style: TextStyle(fontSize: 16))),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: double.maxFinite,
            child: Column(
              children: [
                _showAllDetail(),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: AppColors.COLOR_WHITE,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text("รายการ Loaner",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.COLOR_BLACK,
                                    fontWeight: FontWeight.bold)),
                          ),
                          _showLoaner()
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAllDetail() {
    List<Color> _color = employee.isTrained!
        ? [AppColors.COLOR_GREEN2, AppColors.COLOR_GREEN]
        : [AppColors.COLOR_YELLOW2, AppColors.COLOR_YELLOW];
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(appointment.companyName!,
              style: TextStyle(
                  fontSize: 21,
                  color: AppColors.COLOR_BLACK,
                  fontWeight: FontWeight.bold)),
          Text("เจ้าหน้าที่ : ${appointment.empName}",
              style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT)),
          Container(
              decoration: BoxDecoration(
                  color: _color[1], borderRadius: BorderRadius.circular(50.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                    employee.isTrained! ? "ผ่านการอบรม" : "ไม่ผ่านการอบรม",
                    style: TextStyle(fontSize: 14, color: _color[0])),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month_outlined,
                  color: AppColors.COLOR_PRIMARY, size: 14),
              Text(" วันที่นัดพบ ${appointment.appDate}",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.COLOR_BLACK,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text("เวลา: ${appointment.appTime} น.",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.COLOR_BLACK,
                      fontWeight: FontWeight.bold))
            ],
          ),
          Divider(
            color: AppColors.COLOR_GREY,
            thickness: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("เจ้าหน้าที่ผู้ติดต่อ :",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.COLOR_LIGHT)),
                    Text(appointment.cssdName!,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.COLOR_BLACK,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              VerticalDivider(
                color: AppColors.COLOR_GREY,
                thickness: 2.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("แพทย์ผู้ใช้อุปกรณ์ :",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.COLOR_LIGHT)),
                    Text(appointment.docName!,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.COLOR_BLACK,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: AppColors.COLOR_GREY,
            thickness: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("หน่วยงาน :",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.COLOR_LIGHT)),
                    Text(appointment.organizeName!,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.COLOR_BLACK,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              VerticalDivider(
                color: AppColors.COLOR_GREY,
                thickness: 2.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ผู้ป่วย :",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.COLOR_LIGHT)),
                    Text(appointment.patientName!,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.COLOR_BLACK,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: AppColors.COLOR_GREY,
            thickness: 2.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("วันที่ขอใช้ :",
                  style: TextStyle(fontSize: 12, color: AppColors.COLOR_LIGHT)),
              Row(
                children: [
                  Text(appointment.useDate!,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.COLOR_BLACK,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text("เวลา : ${appointment.useTime} น.",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.COLOR_BLACK,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          _buildButtons(context)
        ],
      ),
    );
  }

  _buildButtons(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: TextButton.icon(
            style: TextButton.styleFrom(
                backgroundColor: AppColors.COLOR_WHITE,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                side: BorderSide(color: AppColors.COLOR_PRIMARY, width: 2.0)),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FillAppointmentPage(
                          isSupplier: false,
                        ))),
            icon: Icon(
              Icons.edit_note_outlined,
              color: AppColors.COLOR_PRIMARY,
            ),
            label: Text("แก้ไขการนัดหมาย",
                style:
                    TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 16))),
      );

  _showLoaner() {
    return Flexible(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: appointment.loaners!.length,
        itemBuilder: (context, index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.COLOR_WHITE,
            elevation: 0.0,
            child: ListTile(
              leading: SizedBox(
                height: 60,
                width: 60,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.COLOR_GREY,
                      border:
                          Border.all(color: AppColors.COLOR_GREY, width: 2.0)),
                  child: appointment.loaners![index].image != null
                      ? null
                      : Icon(Icons.image),
                ),
              ),
              title: Text(appointment.loaners![index].name!,
                  style: TextStyle(fontSize: 16)),
              subtitle: Text(
                appointment.loaners![index].detail!,
                style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )),
      ),
    );
  }
}
