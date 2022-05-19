import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loaner/src/blocs/loaner/bloc/loaner_bloc.dart';
import 'package:loaner/src/models/DropdownModel.dart';
import 'package:loaner/src/models/loaner/LoanerDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/services/LoanerService.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DropdownInput.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:loaner/src/utils/TextFormFieldInput.dart';

class LoanerCreatePage extends StatefulWidget {
  LoanerCreatePage({required this.isEdit, required this.loanerId});

  bool isEdit;
  String loanerId;

  @override
  State<LoanerCreatePage> createState() => _LoanerCreatePageState();
}

class _LoanerCreatePageState extends State<LoanerCreatePage> {
  LoanerDataModel loaner = LoanerDataModel(id: "");
  var _formKey = GlobalKey<FormState>();

  TextEditingController _controllerType = TextEditingController(text: "");
  TextEditingController _controllerImage = TextEditingController(text: "");
  TextEditingController _controllerName = TextEditingController(text: "");
  TextEditingController _controllerDetail = TextEditingController(text: "");
  TextEditingController _controllerQty = TextEditingController(text: "");
  TextEditingController _controllerSize = TextEditingController(text: "");

  File? imageFile;

  @override
  void initState() {
    loading();
    super.initState();
  }

  List<DropdownModel> type = [];
  Future loading() async {
    final _loanerService = LoanerService();
    type = await _loanerService.getLoanerType();
    setState(() {
      context.read<LoanerBloc>().add(LoanerGetDetail(id: widget.loanerId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.COLOR_SWATCH,
          elevation: 0,
          leading: IconButton(
              splashRadius: 18,
              icon:
                  Icon(Icons.arrow_back_outlined, color: AppColors.COLOR_BLACK),
              onPressed: () => Navigator.pop(context)),
          title: Column(
            children: [
              Text(
                Constants.LOANER_SUM_TITLE,
                style: TextStyle(
                  color: AppColors.COLOR_BLACK,
                ),
              )
            ],
          ),
          centerTitle: true,
        ),
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
          onPressed: () => validate(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<LoanerBloc, LoanerState>(
                builder: (context, state) {
                  if (state is LoanerStateGetDetail) {
                    _controllerType.text = state.data.type!;
                  }
                  return buildDropdownInput(_controllerType, type, "หมวดหมู่");
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return BlocBuilder<LoanerBloc, LoanerState>(
      builder: (context, state) {
        if (state is LoanerStateGetDetail) {
          loaner = state.data;
          logger.d(loaner.toJson());
          _controllerType.text = loaner.type ?? '';
          _controllerName.text = loaner.name ?? '';
          _controllerSize.text = loaner.size ?? '';
          _controllerDetail.text = loaner.detail ?? '';
          _controllerQty.text = loaner.qty ?? '';
          _controllerImage.text = loaner.image ?? '';
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [buildTextFormField(_controllerName, "ชื่อรายการ")],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextFormField(_controllerSize, "ขนาด (w x h x l)")
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLongTextFormField(
                      _controllerDetail, "รายละเอียด (ถ้ามี)")
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [buildStockTextFormField(_controllerQty)],
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
                                border:
                                    Border.all(color: AppColors.COLOR_GREY)),
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
                                    fontSize: 12,
                                    color: AppColors.COLOR_LIGHT)),
                            trailing: IconButton(
                                icon: Icon(Icons.delete_outline_outlined,
                                    color: AppColors.COLOR_RED),
                                onPressed: () {
                                  imageFile = null;
                                  // setState(() {});
                                }),
                          ),
                        )
                ],
              )
            ],
          ),
        );
      },
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
    // setState(() {});
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    imageFile = File(pickedFile!.path);
    // setState(() {});
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
      loaner.type = _controllerType.text;
      loaner.image = _controllerImage.text;
      loaner.name = _controllerName.text;
      loaner.detail = _controllerDetail.text;
      loaner.qty = _controllerQty.text;
      loaner.size = _controllerSize.text;

      // context
      //     .read<LoanerBloc>()
      //     .add(LoanerCreate(loaner: loaner, isEdit: widget.isEdit));
      Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) => LoanerPage(
                    isFillForm: false,
                    selectedLoaner: [],
                    isEdit: false,
                  )));
    } else {
      BotToast.showText(text: Constants.TEXT_FORM_FIELD);
    }
  }
}
