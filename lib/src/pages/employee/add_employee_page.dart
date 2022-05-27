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
import 'package:loaner/src/services/Urls.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DefaultImage.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/TextFormFieldInput.dart';
import 'package:transparent_image/transparent_image.dart';

class AddEmployeePage extends StatefulWidget {
  AddEmployeePage({required this.isEdit, required this.empId});
  bool isEdit;
  String empId;
  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  EmployeeDataModel employee =
      EmployeeDataModel(empId: "", isTrained: "1", isActive: "0");
  var _formKey = GlobalKey<FormState>();
  final _sharedPreferencesService = SharedPreferencesService();
  bool isDelete = false;

  TextEditingController _controllerCompany =
      new TextEditingController(text: "");
  TextEditingController _controllerHeadName =
      new TextEditingController(text: "");
  TextEditingController _controllerUsername =
      new TextEditingController(text: "");
  TextEditingController _controllerPassword =
      new TextEditingController(text: "");
  TextEditingController _controllerFirstName =
      new TextEditingController(text: "");
  TextEditingController _controllerLastName =
      new TextEditingController(text: "");
  TextEditingController _controllerDetail = new TextEditingController(text: "");
  TextEditingController _controllerImage = new TextEditingController(text: "");

  File? imageFile;

  Future<void> loading() async {
    _controllerCompany.text =
        await _sharedPreferencesService.preferenceGetDepName();
    setState(() {
      if (widget.empId != "") {
        context.read<EmployeeBloc>().add(EmployeeGetDetail(id: widget.empId));
      }
    });
  }

  @override
  void initState() {
    loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(title: Constants.EMPLOYEE_ADD_TITLE, context: context),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: _buildForm(context)),
              ),
            ),
          ),
        ),
        bottomNavigationBar: imageFile != null || _controllerImage.text != ''
            ? _bottomButton()
            : null);
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
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeStateGetDetail) {
            employee = state.data;
            logger.d(employee.toJson());
            if (_controllerHeadName.text == "" ||
                _controllerFirstName.text == "" ||
                _controllerLastName.text == "" ||
                _controllerUsername.text == "" ||
                _controllerPassword.text == "") {
              _controllerHeadName.text = employee.prefix ?? '';
              _controllerFirstName.text = employee.firstName ?? '';
              _controllerLastName.text = employee.lastName ?? '';
              _controllerDetail.text = employee.detail ?? '';
              _controllerUsername.text = employee.username ?? '';
              _controllerPassword.text = employee.password ?? '';
            }
            if (_controllerImage.text == "" && !isDelete) {
              _controllerImage.text = employee.image ?? '';
            }
          }
          return Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .7,
                  child: SingleChildScrollView(child: _buildInput())),
              const SizedBox(height: 10),
              _buildImportImage()
            ],
          );
        },
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
              buildTextFormField(_controllerUsername, "username"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(_controllerPassword, "password"),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(_controllerHeadName, Constants.prefix, "คำนำหน้า"),
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
              _buildTrainCheckBox(),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("สถานะเจ้าหน้าที่",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildActiveCheckBox(),
            ],
          )
        ],
      ),
    );
  }

  Row _buildTrainCheckBox() {
    return Row(
      children: [
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employee.isTrained = "0";
              setState(() {});
            },
            icon: Icon(employee.isTrained == "0"
                ? Icons.radio_button_checked_outlined
                : Icons.radio_button_unchecked_outlined)),
        Text("เคยอบรม"),
        SizedBox(
          width: 20,
        ),
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employee.isTrained = "1";
              setState(() {});
            },
            icon: Icon(employee.isTrained == "0"
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
        imageFile == null && _controllerImage.text == ""
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
                    child: _controllerImage.text != "" && imageFile != null
                        ? Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          )
                        : FadeInImage.memoryNetwork(
                            imageErrorBuilder: ((context, error, stackTrace) =>
                                defaultImage()),
                            placeholderErrorBuilder:
                                (context, error, stackTrace) => defaultImage(),
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image:
                                '${Urls.imageEmployeeUrl}/${employee.image!}'),
                  ),
                  title: Text(
                    _controllerImage.text != "" && imageFile != null
                        ? imageFile!.path.split("/").last
                        : _controllerImage.text,
                    style:
                        TextStyle(fontSize: 16, color: AppColors.COLOR_PRIMARY),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: _controllerImage.text == ""
                      ? Text(
                          (imageFile!.readAsBytesSync().lengthInBytes /
                                      (1024 * 1024))
                                  .toStringAsFixed(2) +
                              " Mb",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.COLOR_LIGHT))
                      : null,
                  trailing: IconButton(
                      icon: Icon(Icons.delete_outline_outlined,
                          color: AppColors.COLOR_RED),
                      onPressed: () {
                        imageFile = null;
                        _controllerImage.text = "";
                        isDelete = true;
                        setState(() {});
                      }),
                ),
              ),
      ],
    );
  }

  _buildActiveCheckBox() {
    return Row(
      children: [
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employee.isActive = "0";
              setState(() {});
            },
            icon: Icon(employee.isActive == "0"
                ? Icons.radio_button_checked_outlined
                : Icons.radio_button_unchecked_outlined)),
        Text("active"),
        SizedBox(
          width: 20,
        ),
        IconButton(
            highlightColor: AppColors.COLOR_PRIMARY,
            onPressed: () {
              employee.isActive = "1";
              setState(() {});
            },
            icon: Icon(employee.isActive == "0"
                ? Icons.radio_button_unchecked_outlined
                : Icons.radio_button_checked_outlined)),
        Text("inactive"),
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
    _convertBase64();
    setState(() {});
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    imageFile = File(pickedFile!.path);
    _convertBase64();
    setState(() {});
    Navigator.pop(context);
  }

  void _convertBase64() {
    final bytes = imageFile!.readAsBytesSync();
    String img64 = base64Encode(bytes);
    _controllerImage.text = img64;
  }

  void validate() async {
    if (_formKey.currentState!.validate()) {
      employee.username = _controllerUsername.text;
      employee.password = _controllerPassword.text;
      employee.deptId = await _sharedPreferencesService.preferenceGetDepId();
      employee.prefix = _controllerHeadName.text;
      employee.firstName = _controllerFirstName.text;
      employee.lastName = _controllerLastName.text;
      employee.detail = _controllerDetail.text;
      employee.image = _controllerImage.text;

      context.read<EmployeeBloc>().add(EmployeeManage(employee: employee));
      Navigator.pop(context);
    } else {
      BotToast.showText(text: Constants.TEXT_FORM_FIELD);
    }
  }
}
