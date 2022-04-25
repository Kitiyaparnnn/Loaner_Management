import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/InputDecorationDate.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

class FillAppointmentPage extends StatefulWidget {
  FillAppointmentPage({Key? key}) : super(key: key);
  AppointmentData? appointmented;
  @override
  State<FillAppointmentPage> createState() => _FillAppointmentPageState();
}

class NewTime {
  String time;

  NewTime(this.time);

  Map<String, dynamic> toJson() => {
        'time': time,
      };

  @override
  String toString() => '{ time: $time}';
}

class _FillAppointmentPageState extends State<FillAppointmentPage> {
  bool isSupplier = true;
  final appointment = AppointmentData();
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  bool isEnabledButtonSave = true;

  String currentDateSelectText =
      ConvertDateFormat.convertDateFormat(date: DateTime.now());
  DateTime currentDateSelect = DateTime.now();
  String currentTimeSelectText =
      ConvertDateFormat.convertTimeFormat(date: DateTime.now());
  TimeOfDay currentTimeSelect = TimeOfDay.now();

  String companyName = 'POSE';
  TextEditingController _controllerCompanyName =
      new TextEditingController(text: "");
  TextEditingController _controllerEmpName =
      new TextEditingController(text: "");
  TextEditingController _controllerHospitalName =
      new TextEditingController(text: "");
  TextEditingController _controllerOrganizeName =
      new TextEditingController(text: "");
  TextEditingController _controllerCssdName =
      new TextEditingController(text: "");
  TextEditingController _controllerDoctorName =
      new TextEditingController(text: "");
  TextEditingController _controllerDepName =
      new TextEditingController(text: "");
  TextEditingController _controllerPatientName =
      new TextEditingController(text: "");
  TextEditingController _controllerUseDate =
      new TextEditingController(text: "");
  TextEditingController _controllerAppDate =
      new TextEditingController(text: "");
  TextEditingController _controllerUseTime =
      new TextEditingController(text: "");
  TextEditingController _controllerAppTime =
      new TextEditingController(text: "");
  TextEditingController _controllerStatus =
      new TextEditingController(text: Constants.APP_CREATE);

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

  Future<void> _timePickerShow(TextEditingController controller) async {
    TimeOfDay? chooseTime = await showTimePicker(
        context: context,
        helpText: "กรุณาเลือกเวลา",
        cancelText: Constants.TEXT_CANCEL,
        confirmText: Constants.TEXT_CONFIRM,
        initialTime: currentTimeSelect,
        builder: (context, childWidget) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget!);
        });

    if (chooseTime != null) {
      currentTimeSelect = chooseTime;
      controller.text = ConvertDateFormat.convertTimeFormat(
          date: DateTime(currentDateSelect.year, currentDateSelect.month,
              currentDateSelect.minute, chooseTime.hour, chooseTime.minute));

      // updateOneTime(controller);
    }
  }

  @override
  void initState() {
    // _controllerUseDate.text = currentDateSelectText;
    // _controllerAppDate.text = currentDateSelectText;
    // _controllerUseTime.text = currentTimeSelectText;
    // _controllerAppTime.text = currentTimeSelectText;
    // _controllerCompanyName.text = companyName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(title: Constants.FILL_APPOINT_TITLE, context: context),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: _buildForm(context),
            ),
          ),
        ),
        bottomNavigationBar: _bottomButton());
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              primary: AppColors.COLOR_PRIMARY),
          onPressed: () {
            try {
              if (_formKey2.currentState!.validate() &&
                  _formKey.currentState!.validate() &&
                  _controllerUseDate.text != "" &&
                  _controllerAppDate.text != "") {
                validate();
                logger.d(appointment.toJson());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppointmentPage()));
              } else {
                BotToast.showText(text: Constants.TEXT_FORM_FIELD);
              }
            } catch (e) {
              BotToast.showText(text: Constants.TEXT_FORM_FIELD);
            }
          },
          child: Text("บันทึก", style: TextStyle(fontSize: 16))),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildInput(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: _buildInputForm2(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextFormField(_controllerCompanyName, "บริษัท"),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdown(
                      _controllerEmpName, Constants.emp, "เจ้าหน้าที่บริษัท"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm2() {
    return Form(
      key: _formKey,
      child: Column(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(_controllerHospitalName, Constants.hos, "โรงพยาบาล"),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(_controllerOrganizeName, Constants.org,
                "หน่วยงานที่ต้องการติดต่อ"),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField(_controllerCssdName, "เจ้าหน้าที่ผู้ติดต่อ"),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(
                _controllerDoctorName, Constants.doc, "แพทย์ผู้ใช้อุปกรณ์"),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(_controllerDepName, Constants.dep, "หน่วยงาน")
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField(_controllerPatientName, "ชื่อผู้ป่วย")
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: InkWell(
                onTap: () {
                  _datePickerShow(_controllerUseDate);
                },
                child: TextFormField(
                  enabled: false,
                  controller: _controllerUseDate,
                  decoration: inputDecorationDate(
                      hintText: "วันที่ขอใช้", isDate: true),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _timePickerShow(_controllerUseTime);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerUseTime,
                      decoration:
                          inputDecorationDate(hintText: "เวลา", isDate: false),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _datePickerShow(_controllerAppDate);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerAppDate,
                      decoration: inputDecorationDate(
                          hintText: "วันที่นัดเข้าพบ", isDate: true),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onTap: () {
                      _timePickerShow(_controllerAppTime);
                    },
                    enabled: false,
                    controller: _controllerAppTime,
                    decoration:
                        inputDecorationDate(hintText: "เวลา", isDate: false),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildButtons(context),
      ]),
    );
  }

  Widget _buildButtons(BuildContext context) => TextButton.icon(
      style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          minimumSize: Size(MediaQuery.of(context).size.width, 50),
          side: BorderSide(color: AppColors.COLOR_PRIMARY, width: 2.0)),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoanerPage(
                    isFillForm: true,
                    selectedLoaner: [],
                  ))),
      icon: Icon(
        Icons.add_circle_outline_outlined,
        color: AppColors.COLOR_PRIMARY,
      ),
      label: Text("เพิ่มรายการ Loaner",
          style: TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 16)));

  TextFormField _buildTextFormField(
      TextEditingController text, String hintText) {
    return TextFormField(
        validator: (value) => value == null ? "โปรดกรอกข้อมูล" : null,
        controller: text,
        decoration: inputDecoration(hintText: hintText));
  }

  DropdownButtonFormField _buildDropdown(
      TextEditingController form, List<String> items, String hintText) {
    return DropdownButtonFormField(
      validator: (value) => value == null ? "โปรดเลือก" : null,
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
      },
    );
  }

  validate() {
    appointment.companyName = _controllerCompanyName.text;
    appointment.empName = _controllerEmpName.text;
    appointment.hospitalName = _controllerHospitalName.text;
    appointment.organizeName = _controllerOrganizeName.text;
    appointment.cssdName = _controllerCssdName.text;
    appointment.docName = _controllerDepName.text;
    appointment.depName = _controllerDepName.text;
    appointment.patientName = _controllerPatientName.text;
    appointment.useDate = _controllerUseDate.text;
    appointment.appDate = _controllerAppDate.text;
    appointment.useTime = _controllerUseTime.text;
    appointment.appTime = _controllerAppTime.text;
    setState(() {});
  }
}
