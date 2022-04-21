import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/employee/employee_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/LabelFormat.dart';

class AddEmployeePage extends StatefulWidget {
  AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final employeeData = EmployeeDataModel(isTrained: false, image: "");
  var _formKey = GlobalKey<FormState>();
  bool isEnabledButtonSave = true;

  String companyName = 'POSE';
  TextEditingController _controllerfirstName =
      new TextEditingController(text: "");
  TextEditingController _controllerlastName =
      new TextEditingController(text: "");
  TextEditingController _controllerdetail = new TextEditingController(text: "");
  String headName = "คำนำหน้า";

  File? imageFile;

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(Constants.EMPLOYEE_TITLE)),
      backgroundColor: AppColors.COLOR_GREY,
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
          const SizedBox(height: 25),
          _buildImportImage(),
          const SizedBox(height: 30),
          _buildButtonSave(context),
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
                label("บริษัท"),
                _buildTextFormField(),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("คำนำหน้า"),
                _buildDropdown(),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("ชื่อ"),
                _buildTextFormFieldFirstName(context),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("นามสกุล"),
                _buildTextFormFieldLastName(context),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("รายละเอียด"),
                _buildTextFormFieldDetail(),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("ผ่านการ Trained"),
                _buildCheckBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildTextFormField() {
    employeeData.companyName = companyName;
    return Container(
      child: Text(companyName, style: TextStyle(color: AppColors.COLOR_DARK)),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
    );
  }


  DropdownButtonFormField _buildDropdown() {
    return DropdownButtonFormField(
      value: headName,
      items: [
        DropdownMenuItem(child: Text("คำนำหน้า"), value: "คำนำหน้า"),
        DropdownMenuItem(child: Text("นางสาว"), value: "นางสาว"),
        DropdownMenuItem(child: Text("นาง"), value: "นาง"),
        DropdownMenuItem(child: Text("นาย"), value: "นาย"),
      ],
      decoration: _inputDecoration(hintText: 'คำนำหน้า'),
      onChanged: (value) {
        employeeData.headName = value;
      },
    );
  }

  TextFormField _buildTextFormFieldFirstName(BuildContext context) {
    return TextFormField(
      controller: _controllerfirstName,
      style: TextStyle(color: AppColors.COLOR_DARK),
      decoration: _inputDecoration(hintText: "สมใจ"),
      focusNode: firstNameFocusNode,
      onSaved: (value) {
        employeeData.firstName = value;
      },
    );
  }

  TextFormField _buildTextFormFieldLastName(BuildContext context) {
    return TextFormField(
      controller: _controllerlastName,
      style: TextStyle(color: AppColors.COLOR_DARK),
      decoration: _inputDecoration(hintText: "จริงจริง"),
      focusNode: lastNameFocusNode,
      onSaved: (value) {
        employeeData.lastName = value;
      },
    );
  }

  TextFormField _buildTextFormFieldDetail() {
    return TextFormField(
      style: const TextStyle(color: AppColors.COLOR_DARK),
      controller: _controllerdetail,
      decoration:
          _inputDecoration(hintText: "รายละเอียด"),
      onSaved: (value) {
        employeeData.detail = value;
      },
    );
  }

  Row _buildCheckBox() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              employeeData.isTrained = true;
              setState(() {});
            },
            icon: Icon(employeeData.isTrained!
                ? Icons.radio_button_checked_outlined
                : Icons.radio_button_unchecked_outlined)),
        Text("เคย"),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              employeeData.isTrained = false;
              setState(() {});
            },
            icon: Icon(employeeData.isTrained!
                ? Icons.radio_button_unchecked_outlined
                : Icons.radio_button_checked_outlined)),
        Text("ไม่เคย"),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    
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

  Widget _buildImportImage() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.COLOR_DARK),
          ),
          child: imageFile != null
              ? Image.file(
                  imageFile!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : SizedBox(
                  width: 200,
                  height: 200,
                ),
        ),
        Spacer(),
        ElevatedButton(
            child: Text("เพิ่มรูปภาพ"), onPressed: () => _showImageDialog())
      ],
    );
  }

  Widget _buildButtonSave(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
            onPressed: () {
              try {
                _formKey.currentState!.save();
                imageFile != null ? _convertBase64() : null;
                logger.d(employeeData.toJson());
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => EmployeePage()));
              } catch (e) {
                BotToast.showText(
                    text: Constants.TEXT_FORM_FIELD);
              }
            },
            child: Text("บันทึก")),
      );

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Please choose an option",
              style: TextStyle(color: AppColors.COLOR_DARK),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    imageFile = File(pickedFile!.path);
    setState(() {});
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    imageFile = File(pickedFile!.path);
    setState(() {});
    Navigator.pop(context);
  }

  void _convertBase64() {
    final bytes = imageFile!.readAsBytesSync();
    String img64 = base64Encode(bytes);
    employeeData.image = img64;
  }
}
