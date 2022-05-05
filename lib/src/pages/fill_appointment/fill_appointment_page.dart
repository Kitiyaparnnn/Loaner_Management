import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/pages/home/home_page.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AskForConfirmToSave.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/ConvertDateFormat.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/InputDecorationDate.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/SelectDecoration.dart';

class FillAppointmentPage extends StatefulWidget {
  FillAppointmentPage({required this.isSupplier, required this.appointStatus});

  bool isSupplier;
  String appointStatus;
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
  EmployeeModel employee = EmployeeModel();

  AppointmentDataModel appointment =
      AppointmentDataModel(status: "0", loaners: []);
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();

  String currentDateSelectText =
      ConvertDateFormat.convertDateFormat(date: DateTime.now());
  DateTime currentDateSelect = DateTime.now();
  String currentTimeSelectText =
      ConvertDateFormat.convertTimeFormat(date: DateTime.now());
  TimeOfDay currentTimeSelect = TimeOfDay.now();

  TextEditingController _controllerCompanyName =
      new TextEditingController(text: "");
  TextEditingController _controllerEmpId = new TextEditingController(text: "");
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
    }
  }

  bool isLoading = true;
  bool isDocument = false;
  bool isFillAppoint = false;

  @override
  void initState() {
    isDocument = widget.appointStatus == "0" ? false : true;
    // getCompanyName();
    getDocumentDetail();
    super.initState();
  }

  getDocumentDetail() {
    if (!isDocument) {
      context.read<AppointmentBloc>().add(AppointmentClear());
    }
  }

  Future<void> getCompanyName() async {
    final _sharedPreferencesService = SharedPreferencesService();
    _controllerCompanyName.text =
        await _sharedPreferencesService.preferenceGetCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
            title: isDocument
                ? Constants.EDIT_APPOINT_TITLE
                : Constants.FILL_APPOINT_TITLE,
            context: context),
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
            validate(2);
          },
          child: Text("บันทึก", style: TextStyle(fontSize: 16))),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          // if (state is AppointmentStateLoading) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          if (state is AppointmentStateGetDetail) {
            logger.w("123");
            if (!isFillAppoint) {
              // logger.w("123");
              appointment = state.data;
              isFillAppoint = true;
              _controllerCompanyName.text = appointment.companyName!;
              _controllerEmpId.text = appointment.empId!;
              _controllerHospitalName.text = appointment.hospitalName!;
              _controllerOrganizeName.text = appointment.organizeName!;
              _controllerCssdName.text = appointment.cssdName!;
              _controllerDoctorName.text = appointment.docName!;
              _controllerDepName.text = appointment.depName!;
              _controllerPatientName.text = appointment.patientName!;
              _controllerUseDate.text = appointment.useDate!;
              _controllerUseTime.text = appointment.useTime!;
              _controllerAppDate.text = appointment.appDate!;
              _controllerAppTime.text = appointment.appTime!;
            }
          }
          return Column(
            children: [
              const SizedBox(height: 10),
              _buildInput(),
              Divider(
                color: AppColors.COLOR_GREY,
                thickness: 2.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildInputForm2(),
                ),
              ),
            ],
          );
        },
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
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdown(
                      _controllerEmpId, Constants.emp, "เจ้าหน้าที่บริษัท"),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                  visible: widget.isSupplier ? false : true,
                  child: BlocBuilder<AppointmentBloc, AppointmentState>(
                    builder: (context, state) {
                      if (state is AppointmentStateGetDetail) {
                        employee = state.employee;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ผ่านการอบรม",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          _buildCheckBox(),
                        ],
                      );
                    },
                  ))
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
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(_controllerOrganizeName, Constants.org,
                "หน่วยงานที่ต้องการติดต่อ"),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField(_controllerCssdName, "เจ้าหน้าที่ผู้ติดต่อ"),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(
                _controllerDoctorName, Constants.doc, "แพทย์ผู้ใช้อุปกรณ์"),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(_controllerDepName, Constants.dep, "หน่วยงาน")
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField(_controllerPatientName, "ชื่อผู้ป่วย")
          ],
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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
                  InkWell(
                    onTap: () {
                      _timePickerShow(_controllerAppTime);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerAppTime,
                      decoration:
                          inputDecorationDate(hintText: "เวลา", isDate: false),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildButtonAddLoaner(context),
      ]),
    );
  }

  Widget _buildButtonAddLoaner(BuildContext context) => Visibility(
        visible: widget.isSupplier,
        child: TextButton.icon(
            style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                side: BorderSide(color: AppColors.COLOR_PRIMARY, width: 2.0)),
            onPressed: () => {validate(1)},
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: AppColors.COLOR_PRIMARY,
            ),
            label: Text("เพิ่มรายการ Loaner",
                style:
                    TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 16))),
      );

  TextFormField _buildTextFormField(
      TextEditingController text, String hintText) {
    return TextFormField(
        // onChanged: (value) => text.text = value,
        enabled: hintText == "บริษัท" ? false : true,
        validator: (value) => value == "" ? "โปรดกรอกข้อมูล" : null,
        controller: text,
        decoration: inputDecoration(hintText: hintText));
  }

  DropdownButtonFormField _buildDropdown(
      TextEditingController form, Map<String, String> items, String hintText) {
    return DropdownButtonFormField(
      value: widget.isSupplier ? null : form.text,
      validator: (value) => value == null ? "โปรดเลือก" : null,
      decoration:
          selectDecoration(hintText: widget.isSupplier ? hintText : form.text),
      icon: Icon(Icons.expand_more_rounded),
      items: items.keys.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(items[value]!),
        );
      }).toList(),
      onChanged: (value) {
        form.text = value;
      },
    );
  }

  validate(int button) {
    if (_formKey2.currentState!.validate() &&
        _formKey.currentState!.validate() &&
        _controllerUseDate.text != "" &&
        _controllerAppDate.text != "") {
      appointment.companyName = _controllerCompanyName.text;
      appointment.empId = _controllerEmpId.text;
      appointment.hospitalName = _controllerHospitalName.text;
      appointment.organizeName = _controllerOrganizeName.text;
      appointment.cssdName = _controllerCssdName.text;
      appointment.docName = _controllerDoctorName.text;
      appointment.depName = _controllerDepName.text;
      appointment.patientName = _controllerPatientName.text;
      appointment.useDate = _controllerUseDate.text;
      appointment.appDate = _controllerAppDate.text;
      appointment.useTime = _controllerUseTime.text;
      appointment.appTime = _controllerAppTime.text;
      logger.d(appointment.toJson());
      if (button == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoanerPage(
                      isFillForm: true,
                      selectedLoaner: [],
                      isEdit: false,
                    )));
      } else {
        // logger.d(appointment.toJson());
        askForConfirmToSave(
            context: context,
            isSupplier: widget.isSupplier,
            appointment: appointment,
            employee: employee);
      }
    } else {
      BotToast.showText(text: Constants.TEXT_FORM_FIELD);
    }
  }

  Row _buildCheckBox() {
    return Row(
      children: [
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employee.isTrained = true;
              setState(() {});
            },
            icon: Icon(employee.isTrained!
                ? Icons.radio_button_checked_outlined
                : Icons.radio_button_unchecked_outlined)),
        Text("เคยอบรม"),
        SizedBox(
          width: 20,
        ),
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employee.isTrained = false;
              setState(() {});
            },
            icon: Icon(employee.isTrained!
                ? Icons.radio_button_unchecked_outlined
                : Icons.radio_button_checked_outlined)),
        Text("ไม่เคยอบรม"),
      ],
    );
  }
}
