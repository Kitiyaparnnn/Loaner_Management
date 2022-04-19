import 'package:flutter/material.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/pages/employee/employee_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

class AddEmployeePage extends StatefulWidget {
  AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final employeeData = EmployeeDataModel();
  var _formKey = GlobalKey<FormState>();
  bool isEnabledButtonSave = true;

  String companyName = 'POSE';
  TextEditingController _controllerfirstName =
      new TextEditingController(text: "");
  TextEditingController _controllerlastName =
      new TextEditingController(text: "");
  TextEditingController _controllerdetail = new TextEditingController(text: "");
  String headName = '';
  bool isTrained = false;
  String image = '';

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(Constants.EMPLOYEE_TITLE)),
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SingleChildScrollView(
              child: Container(
            child: Center(
                child: Column(
              children: [const SizedBox(height: 30), _buildForm(context)],
            )),
          )),
        ),
      )),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          _buildInput(),
          const SizedBox(height: 30),
          _buildButtonLogin(context),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("บริษัท"),
                _buildTextFormField(),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("คำนำหน้า"),
                _buildDropdown(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("ชื่อ"),
                _buildTextFormFieldFirstName(context),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("นามสกุล"),
                _buildTextFormFieldLastName(context),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("รายละเอียด"),
                _buildTextFormFieldDetail(),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("ผ่านการ Trained"),
                _buildCheckBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Container(
        padding: const EdgeInsets.only(left: 5, bottom: 5),
        child: Text(
          "$text",
          style: const TextStyle(
              color: AppColors.COLOR_DARK,
              letterSpacing: 0.15,
              fontWeight: FontWeight.w500),
        ),
      );

  TextFormField _buildTextFormField() {
    return TextFormField(
      style: const TextStyle(color: AppColors.COLOR_DARK),
      decoration:
          _inputDecoration(hintText: "บริษัท โพส จำกัด", contextBloc: context),
      onSaved: (value) {
        employeeData.companyName = companyName;
      },
    );
  }

  DropdownButtonFormField _buildDropdown() {
    return DropdownButtonFormField(
      value: headName,
      items: [
        DropdownMenuItem(child: Text("นางสาว"), value: "นางสาว"),
        DropdownMenuItem(child: Text("นาง"), value: "นาง"),
        DropdownMenuItem(child: Text("นาย"), value: "นาย"),
      ],
      decoration: _inputDecoration(hintText: 'คำนำหน้า', contextBloc: context),
      onChanged: (value) {
        employeeData.headName = value;
      },
    );
  }

  TextFormField _buildTextFormFieldFirstName(BuildContext context) {
    return TextFormField(
      controller: _controllerfirstName,
      style: TextStyle(color: AppColors.COLOR_DARK),
      decoration: _inputDecoration(hintText: "สมใจ", contextBloc: context),
      focusNode: firstNameFocusNode,
      onSaved: (value) {
        employeeData.firstName = value;
      },
      onFieldSubmitted: (String value) {
        _formKey.currentState!.save();
        // BlocProvider.of<LoginBloc>(context).add(LoginEventOnPress(loginData: loginData));
      },
    );
  }

  TextFormField _buildTextFormFieldLastName(BuildContext context) {
    return TextFormField(
      controller: _controllerlastName,
      style: TextStyle(color: AppColors.COLOR_DARK),
      decoration: _inputDecoration(hintText: "จริงจริง", contextBloc: context),
      focusNode: firstNameFocusNode,
      onSaved: (value) {
        employeeData.lastName = value;
      },
      onFieldSubmitted: (String value) {
        _formKey.currentState!.save();
        // BlocProvider.of<LoginBloc>(context).add(LoginEventOnPress(loginData: loginData));
      },
    );
  }

  TextFormField _buildTextFormFieldDetail() {
    return TextFormField(
      style: const TextStyle(color: AppColors.COLOR_DARK),
      controller: _controllerdetail,
      decoration:
          _inputDecoration(hintText: "รายละเอียด", contextBloc: context),
      onSaved: (value) {
        employeeData.detail = value;
      },
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(firstNameFocusNode);
        FocusScope.of(context).requestFocus(lastNameFocusNode);
      },
    );
  }

  Row _buildCheckBox() {
    return Row(
      children: [
        Container(
          child: Row(children: [
            Checkbox(value: true, onChanged: (value) => employeeData.isTrained = value),
            Text("เคย")
          ],),
        ),
        Container(
          child: Row(children: [
            Checkbox(value: false, onChanged: (value) => employeeData.isTrained = value),
            Text("ไม่เคย")
          ],),
        )
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required BuildContext contextBloc,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 15),
      hintStyle: const TextStyle(color: AppColors.COLOR_GREY),
      fillColor: AppColors.COLOR_WHITE,
      filled: true,
      hintText: '$hintText',
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: const BorderSide(
          color: AppColors.COLOR_PRIMARY,
          width: 2,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildButtonLogin(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(0.0),
        color: Colors.transparent,
        onPressed: isEnabledButtonSave
            ? () async {
                _formKey.currentState!.save();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmployeePage()));
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.COLOR_PRIMARY,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          constraints: BoxConstraints(minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            "บันทึก",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
