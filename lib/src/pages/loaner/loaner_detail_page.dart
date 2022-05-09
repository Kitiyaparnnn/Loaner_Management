import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';

class LoanerDetailPage extends StatefulWidget {
  LoanerDetailPage({required this.loaner});

  LoanerModel loaner;

  @override
  State<LoanerDetailPage> createState() => _LoanerDetailPageState();
}

class _LoanerDetailPageState extends State<LoanerDetailPage> {
  TextEditingController _controllernote = new TextEditingController(text: "");
  var _formKey = GlobalKey<FormState>();
  int no = 0;

  List<LoanerModel> loaners = [
    LoanerModel(
        name: 'LoanerA',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        rent: 0,
        note: ''),
    LoanerModel(
        name: 'LoanerB',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        image: '',
        rent: 0,
        note: ''),
    LoanerModel(
        name: 'LoanerC',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        image: '',
        rent: 0,
        note: ''),
    LoanerModel(
        name: 'LoanerD',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        image: '',
        rent: 0,
        note: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "", context: context),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                primary: AppColors.COLOR_PRIMARY),
            onPressed: () {
              validate();
            },
            child: Text("เพิ่มรายการ", style: TextStyle(fontSize: 16))),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              _showImage(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: .50 * MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: AppColors.COLOR_WHITE,
                  ),
                  child: _showDetail(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: AppColors.COLOR_BLACK),
          // ),
          child: widget.loaner.image == null
              ? SizedBox(
                  height: 200,
                  width: 200,
                  child: Icon(Icons.image),
                )
              : SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("${Constants.IMAGE_DIR}/sample.png"))),
    );
  }

  _showDetail() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.loaner.name!, style: TextStyle(fontSize: 25)),
          SizedBox(height: 10),
          label("รายละเอียด"),
          Text(widget.loaner.detail!,
              style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT)),
          SizedBox(height: 10),
          label("หมายเหตุ"),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            style: const TextStyle(color: AppColors.COLOR_LIGHT, fontSize: 16),
            controller: _controllernote,
            decoration: inputDecoration(hintText: "หมายเหตุ"),
            onChanged: (value) {
              _controllernote.text = value;
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    no = no - 1;
                    setState(() {});
                  },
                  child: Image.asset("${Constants.IMAGE_DIR}/minus.png")),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('$no',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
              InkWell(
                  onTap: () {
                    no = no + 1;
                    setState(() {});
                  },
                  child: Image.asset("${Constants.IMAGE_DIR}/plus.png"))
            ],
          ),
        ],
      ),
    );
  }

  validate() {
    if (no > 0) {
      widget.loaner.rent = no;
      widget.loaner.note = _controllernote.text;
      context
          .read<AppointmentBloc>()
          .add(AppointmentAddLoaner(loaner: widget.loaner));
      Navigator.pop(
        context,
      );
    } else {
      BotToast.showText(text: Constants.TEXT_FORM_FIELD);
    }
  }
}
