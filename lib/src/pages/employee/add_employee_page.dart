import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loaner/src/blocs/employee/bloc/employee_bloc.dart';
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/employee/employee_page.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/TextFormFieldInput.dart';

class AddEmployeePage extends StatefulWidget {
  AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final employeeData = EmployeeDataModel(isTrained: false);
  var _formKey = GlobalKey<FormState>();

  TextEditingController _controllerCompany =
      new TextEditingController(text: "");
  TextEditingController _controllerHeadName =
      new TextEditingController(text: "");
  TextEditingController _controllerFirstName =
      new TextEditingController(text: "");
  TextEditingController _controllerLastName =
      new TextEditingController(text: "");
  TextEditingController _controllerDetail = new TextEditingController(text: "");
  TextEditingController _controllerImage = new TextEditingController(text: "");

  File? imageFile;

  Future<void> getCompanyName() async {
    final _sharedPreferencesService = SharedPreferencesService();
    _controllerCompany.text =
        await _sharedPreferencesService.preferenceGetDepName();
  }

  @override
  void initState() {
    getCompanyName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(title: Constants.EMPLOYEE_ADD_TITLE, context: context),
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
              children: [const SizedBox(height: 10), _buildForm(context)],
            ))),
          ),
        )),
        bottomNavigationBar: imageFile != null ? _bottomButton() : null);
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              primary: AppColors.COLOR_PRIMARY),
          onPressed: () => validate(),
          child: Text("บันทึก", style: TextStyle(fontSize: 16))),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          _buildInput(),
          const SizedBox(height: 10),
          _buildImportImage(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(_controllerCompany, "บริษัท"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(_controllerHeadName, Constants.head, "คำนำหน้า"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(_controllerFirstName, "ชื่อ"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(_controllerLastName, "นามสกุล"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLongTextFormField(_controllerDetail, "รายละเอียด (ถ้ามี)"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ผ่านการอบรม",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildCheckBox(),
            ],
          )
        ],
      ),
    );
  }

  Row _buildCheckBox() {
    return Row(
      children: [
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employeeData.isTrained = true;
              setState(() {});
            },
            icon: Icon(employeeData.isTrained!
                ? Icons.radio_button_checked_outlined
                : Icons.radio_button_unchecked_outlined)),
        Text("เคยอบรม"),
        SizedBox(
          width: 20,
        ),
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employeeData.isTrained = false;
              setState(() {});
            },
            icon: Icon(employeeData.isTrained!
                ? Icons.radio_button_unchecked_outlined
                : Icons.radio_button_checked_outlined)),
        Text("ไม่เคยอบรม"),
      ],
    );
  }

  Widget _buildImportImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("อัปโหลดรูปถ่ายของคุณ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("เราต้องแน่ใจว่าเป็นคุณ ถ่ายรูปให้เห็นหน้า",
            style: TextStyle(fontSize: 12, color: AppColors.COLOR_LIGHT)),
        const SizedBox(height: 10),
        imageFile == null
            ? InkWell(
                onTap: () => _showImageDialog(),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.COLOR_WHITE,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.COLOR_GREY)),
                  height: 150,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => _showImageDialog(),
                            icon: Icon(Icons.file_download_outlined,
                                color: AppColors.COLOR_PRIMARY)),
                        Text("ลากรูปภาพไปที่โซนหรือคลิกอัปโหลด",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.COLOR_LIGHT))
                      ],
                    ),
                  ),
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColors.COLOR_WHITE,
                elevation: 0.0,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.COLOR_GREY,
                        border: Border.all(
                            color: AppColors.COLOR_GREY, width: 2.0)),
                    height: 60,
                    width: 60,
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    imageFile!.path.split("/").last,
                    style:
                        TextStyle(fontSize: 16, color: AppColors.COLOR_PRIMARY),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                      (imageFile!.readAsBytesSync().lengthInBytes /
                                  (1024 * 1024))
                              .toStringAsFixed(2) +
                          " Mb",
                      style: TextStyle(
                          fontSize: 12, color: AppColors.COLOR_LIGHT)),
                  trailing: IconButton(
                      icon: Icon(Icons.delete_outline_outlined,
                          color: AppColors.COLOR_RED),
                      onPressed: () {
                        imageFile = null;
                        setState(() {});
                      }),
                ),
              )
      ],
    );
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              Constants.TEXT_IMPORT_IMAGE,
              style: TextStyle(color: AppColors.COLOR_BLACK, fontSize: 16),
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
    _controllerImage.text = img64;
  }

  void validate() {
    if (_formKey.currentState!.validate()) {
      _convertBase64();
      employeeData.companyName = _controllerCompany.text;
      employeeData.headName = _controllerHeadName.text;
      employeeData.firstName = _controllerFirstName.text;
      employeeData.lastName = _controllerLastName.text;
      employeeData.detail = _controllerDetail.text;
      employeeData.image = _controllerImage.text;

      context.read<EmployeeBloc>().add(EmployeeManage(employee: employeeData));
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => EmployeePage()));
    } else {
      BotToast.showText(text: Constants.TEXT_FORM_FIELD);
    }
  }
}
