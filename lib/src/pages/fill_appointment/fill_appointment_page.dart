import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/DropdownModel.dart';
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
import 'package:loaner/src/utils/DropdownInput.dart';
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
      AppointmentDataModel(status: "0", loaners: [], id: "");
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  final _sharedPreferencesService = SharedPreferencesService();

  String currentDateSelectText =
      ConvertDateFormat.convertDateFormat(date: DateTime.now());
  DateTime currentDateSelect = DateTime.now();
  String currentTimeSelectText =
      ConvertDateFormat.convertTimeFormat(date: DateTime.now());
  TimeOfDay currentTimeSelect = TimeOfDay.now();

  TextEditingController _controllerCompanyName =
      TextEditingController(text: "");
  TextEditingController _controllerEmpId = TextEditingController(text: "");
  TextEditingController _controllerHospitalName =
      TextEditingController(text: "");
  TextEditingController _controllerOrganizeName =
      TextEditingController(text: "");
  TextEditingController _controllerCssdName = TextEditingController(text: "");
  TextEditingController _controllerDoctorName = TextEditingController(text: "");
  TextEditingController _controllerDepName = TextEditingController(text: "");
  TextEditingController _controllerPatientName =
      TextEditingController(text: "");
  TextEditingController _controllerUseDate = TextEditingController(text: "");
  TextEditingController _controllerAppDate = TextEditingController(text: "");
  TextEditingController _controllerUseTime = TextEditingController(text: "");
  TextEditingController _controllerAppTime = TextEditingController(text: "");
  TextEditingController _controllerStatus =
      TextEditingController(text: Constants.APP_CREATE);

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
  String supId = "";
  String empId = "";
  List<DropdownModel> emp = [];

  @override
  void initState() {
    isDocument = widget.appointStatus == "0" ? false : true;
    getDocumentDetail();
    super.initState();
  }

  getDocumentDetail() async {
    if (!isDocument) {
      context.read<AppointmentBloc>().add(AppointmentClear());
      _controllerCompanyName.text =
          await _sharedPreferencesService.preferenceGetDepName();
      supId = await _sharedPreferencesService.preferenceGetDepId();
      empId = await _sharedPreferencesService.preferenceGetUserId();
      _controllerEmpId.text = empId;
      context
          .read<AppointmentBloc>()
          .add(AppointmentGetGetSupEmpandHos(supId: supId));
    }
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
      // bottomNavigationBar: _bottomButton()
    );
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
            // logger.w("123");
            if (!isFillAppoint) {
              // logger.w("123");
              appointment = state.data;
              isFillAppoint = true;
              _controllerCompanyName.text = appointment.supId!;
              _controllerEmpId.text = appointment.supEmpId!;
              _controllerHospitalName.text = appointment.hospitalId!;
              _controllerOrganizeName.text = appointment.hosDeptId!;
              _controllerCssdName.text = appointment.hosEmpId!;
              _controllerDoctorName.text = appointment.docId!;
              _controllerDepName.text = appointment.hospitalId!;
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
                  BlocBuilder<AppointmentBloc, AppointmentState>(
                    builder: (context, state) {
                      if (state is AppointmentStateGetGetSupEmpandHos) {
                        emp = state.supEmp;
                        logger.w("build");
                      }
                      return buildDropdownInput(
                          _controllerEmpId, emp, "เจ้าหน้าที่บริษัท");
                    },
                  ),
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

  List<DropdownModel> hospital = [];

  Widget _buildInputForm2() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        List<DropdownModel> hosDept = [];
        List<DropdownModel> hosEmp = [];
        List<DropdownModel> hosDoc = [];
        if (state is AppointmentStateGetHosDetail) {
          hosDept = state.dept;
          hosEmp = state.emp;
          hosDoc = state.doctor;
          _controllerCssdName.text = hosEmp[0].id.toString();
          _controllerDepName.text = hosDept[0].id.toString();
          _controllerDoctorName.text = hosDoc[0].id.toString();
          _controllerOrganizeName.text = hosDept[0].id.toString();
        }
        if (state is AppointmentStateGetGetSupEmpandHos) {
          hospital = state.hos;
        }
        return Form(
          key: _formKey,
          child: Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdownInput(
                    _controllerHospitalName, hospital, "โรงพยาบาล"),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropdownInput(_controllerOrganizeName, hosDept,
                    "หน่วยงานที่ต้องการติดต่อ"),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropdownInput(
                    _controllerCssdName, hosEmp, "เจ้าหน้าที่ผู้ติดต่อ"),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropdownInput(
                    _controllerDoctorName, hosDoc, "แพทย์ผู้ใช้อุปกรณ์"),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropdownInput(_controllerDepName, hosDept, "หน่วยงาน")
                // DropdownButtonFormField(
                //   value: dept,
                //   validator: (value) => value == null ? "โปรดเลือก" : null,
                //   decoration: selectDecoration(hintText: "หน่วยงาน"),
                //   icon: Icon(Icons.expand_more_rounded),
                //   items: hosDept.map<DropdownMenuItem<String>>((item) {
                //     logger.d(item.toJson());
                //     return DropdownMenuItem(
                //       value: item.id ?? "",
                //       child: Text(item.name == null ? "" : item.name!),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     dept = value.toString();
                //     logger.d("con: ${dept}");
                //   },
                // )
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
                          decoration: inputDecorationDate(
                              hintText: "เวลา", isDate: false),
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
                          decoration: inputDecorationDate(
                              hintText: "เวลา", isDate: false),
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
      },
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

  DropdownButtonFormField _buildDropdownInput(
      TextEditingController form, List<DropdownModel> items, String hintText) {
    return DropdownButtonFormField(
      value: form.text == "" ? null : form.text,
      validator: (value) => value == null ? "โปรดเลือก" : null,
      decoration: selectDecoration(hintText: hintText),
      icon: Icon(Icons.expand_more_rounded),
      items: items.map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem(
          value: item.id,
          child: Text(item.name == null ? "" : item.name!),
        );
      }).toList(),
      onChanged: (value) {
        form.text = value;
        context
            .read<AppointmentBloc>()
            .add(AppointmentGetHosDetail(hosId: value));
      },
    );
  }

  validate(int button) {
    if (_formKey2.currentState!.validate() &&
        _formKey.currentState!.validate() &&
        _controllerUseDate.text != "" &&
        _controllerAppDate.text != "") {
      appointment.supId = supId;
      appointment.supEmpId = _controllerEmpId.text;
      appointment.hospitalId = _controllerHospitalName.text;
      appointment.hosDeptId = _controllerOrganizeName.text;
      appointment.hosEmpId = _controllerCssdName.text;
      appointment.docId = _controllerDoctorName.text;
      appointment.useDeptId = _controllerDepName.text;
      appointment.patientName = _controllerPatientName.text;
      appointment.useDate = _controllerUseDate.text;
      appointment.appDate = _controllerAppDate.text;
      appointment.useTime = _controllerUseTime.text;
      appointment.appTime = _controllerAppTime.text;
      // logger.d(appointment.toJson());
      if (button == 1) {
        context
            .read<AppointmentBloc>()
            .add(AppointmentSetAppoint(app: appointment));
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
