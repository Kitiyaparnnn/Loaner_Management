import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loaner/src/models/loaner/LoanerDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/TextFormFieldInput.dart';

class LoanerCreatePage extends StatefulWidget {
  LoanerCreatePage({Key? key}) : super(key: key);

  @override
  State<LoanerCreatePage> createState() => _LoanerCreatePageState();
}

class _LoanerCreatePageState extends State<LoanerCreatePage> {
  final loaner = LoanerDataModel();
  var _formKey = GlobalKey<FormState>();

  TextEditingController _controllerGroup = new TextEditingController(text: "");
  TextEditingController _controllerImage = new TextEditingController(text: "");
  TextEditingController _controllerName = new TextEditingController(text: "");
  TextEditingController _controllerDetail = new TextEditingController(text: "");
  TextEditingController _controllerStock = new TextEditingController(text: "");

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(title: Constants.LOANER_SUM_TITLE, context: context),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: _buildForm(context),
              ),
            ),
          ),
        ),
        bottomNavigationBar: imageFile != null ? _bottomButton() : null);
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
              if (_formKey.currentState!.validate()) {
                validate();
                logger.d(loaner.toJson());
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoanerPage(
                              isFillForm: false,
                              selectedLoaner: [],
                            )));
              } else {
                BotToast.showText(text: Constants.TEXT_FORM_FIELD);
              }
            } catch (e) {
              // print(e);
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
          const SizedBox(height: 10),
          _buildInput(),
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
                buildDropdown(_controllerGroup, Constants.group, "หมวดหมู่"),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildTextFormField(_controllerName, "ชื่อรายการ")],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLongTextFormField(_controllerDetail, "รายละเอียด (ถ้ามี)")
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildStockTextFormField(_controllerStock)],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("อัปโหลดรูปถ่าย Loaner",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                                        fontSize: 12,
                                        color: AppColors.COLOR_LIGHT))
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
                            style: TextStyle(
                                fontSize: 16, color: AppColors.COLOR_PRIMARY),
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
            )
          ],
        ));
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
    _convertBase64();
    loaner.group = _controllerGroup.text;
    loaner.image = _controllerImage.text;
    loaner.name = _controllerName.text;
    loaner.detail = _controllerDetail.text;
    loaner.stock = _controllerStock.text;
    setState(() {});
  }
}
