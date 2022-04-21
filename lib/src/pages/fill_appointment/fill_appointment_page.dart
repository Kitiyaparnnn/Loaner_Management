import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

class FillAppointmentPage extends StatefulWidget {
  FillAppointmentPage({Key? key}) : super(key: key);

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
    _controllerUseDate.text = currentDateSelectText;
    _controllerAppDate.text = currentDateSelectText;
    _controllerUseTime.text = currentTimeSelectText;
    _controllerAppTime.text = currentTimeSelectText;
    _controllerCompanyName.text = companyName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true, title: Text(Constants.FILL_APPOINT_TITLE)),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: _buildForm(context),
            ),
          ),
        ));
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
          // const SizedBox(height: 25),
          Expanded(
            child: SingleChildScrollView(
              child: _buildInputForm2(),
            ),
          ),
          _buildButtons(context),
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
                  label("บริษัท"),
                  _buildTextFormField(_controllerCompanyName, "POSE"),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label("เจ้าหน้าที่บริษัท"),
                  _buildDropdown(_controllerEmpName, Constants.emp),
                ],
              ),
            ],
          ),
          const SizedBox(
              height: 25,
              child: Divider(
                thickness: 5.0,
                color: AppColors.COLOR_GREY,
              )),
        ],
      ),
    );
  }

  Widget _buildInputForm2() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("โรงพยาบาล"),
              _buildDropdown(_controllerHospitalName, Constants.hos),
            ],
          ),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("หน่วยงานที่ต้องการตืดต่อ"),
              _buildDropdown(_controllerOrganizeName, Constants.org),
            ],
          ),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("เจ้าหน้าที่ผู้ติดต่อ"),
              _buildTextFormField(_controllerCssdName, "เจ้าหน้าที่ผู้ติดต่อ"),
            ],
          ),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label("แพทย์ผู้ใช้อุปกรณ์"),
              _buildDropdown(_controllerDoctorName, Constants.doc),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("หน่วยงาน"),
                    _buildDropdown(_controllerDepName, Constants.dep)
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("ชื่อผู้ป่วย"),
                    _buildTextFormField(_controllerPatientName, "ชื่อผู้ป่วย")
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("วันที่ขอใช้"),
                    InkWell(
                      onTap: () {
                        _datePickerShow(_controllerUseDate);
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: _controllerUseDate,
                        decoration:
                            inputDecoration(hintText: currentDateSelectText),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("เวลา"),
                    InkWell(
                      onTap: () {
                        _timePickerShow(_controllerUseTime);
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: _controllerUseTime,
                        decoration:
                            inputDecoration(hintText: currentTimeSelectText),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("วันที่นัดหมายเข้าพบ"),
                    InkWell(
                      onTap: () {
                        _datePickerShow(_controllerAppDate);
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: _controllerUseDate,
                        decoration:
                            inputDecoration(hintText: currentTimeSelectText),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("เวลา"),
                    InkWell(
                      onTap: () {
                        _timePickerShow(_controllerAppTime);
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: _controllerAppTime,
                        decoration:
                            inputDecoration(hintText: currentTimeSelectText),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) => Row(
        children: [
          InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoanerSumPage())),
              child: Column(
                children: [
                  Icon(Icons.shopping_basket_outlined),
                  Text("รายการ",
                      style:
                          TextStyle(color: AppColors.COLOR_DARK, fontSize: 12))
                ],
              )),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                try {
                  if (_formKey2.currentState!.validate() &&
                      _formKey.currentState!.validate()) {
                    validate();
                    logger.d(appointment.toJson());
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  isSupplier: isSupplier,
                                )));
                  }
                } catch (e) {
                  BotToast.showText(text: Constants.TEXT_FORM_FIELD);
                }
              },
              child: Text("บันทึก"))
        ],
      );

  TextFormField _buildTextFormField(
      TextEditingController text, String hintText) {
    return TextFormField(
        validator: (value) => value == null ? "โปรดกรอกข้อมูล" : null,
        controller: text,
        decoration: inputDecoration(hintText: hintText));
  }

  DropdownButtonFormField _buildDropdown(
      TextEditingController form, List<String> items) {
    return DropdownButtonFormField(
      validator: (value) => value == null ? "โปรดเลือก" : null,
      decoration: selectDecoration(),
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
