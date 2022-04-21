// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/InputDecoration.dart';
import 'package:loaner/src/utils/LabelFormat.dart';

class LoanerDetailPage extends StatefulWidget {
  LoanerDetailPage({required this.loaner, required this.selectedLoaner});

  LoanerModel loaner;
  List<LoanerModel> selectedLoaner;
  @override
  State<LoanerDetailPage> createState() => _LoanerDetailPageState();
}

class _LoanerDetailPageState extends State<LoanerDetailPage> {
  TextEditingController _controllerdetail = new TextEditingController(text: "");
  var _formKey = GlobalKey<FormState>();
  int no = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // bottomNavigationBar: BottomAppBar(
      //   // width: MediaQuery.of(context).size.width,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //           onPressed: () {
      //             _formKey.currentState!.save();
      //             widget.loaner.no = no;
      //             logger.d(widget.loaner.toJson());
      //             Navigator.pop(context);
      //           },
      //           child: Text('เพิ่มรายการ')),
      //     ],
      //   ),
      // ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          // color: Colors.green,
          child: SingleChildScrollView(
            child: Container(
              // height: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        _showDetail(),
                        Divider(
                          thickness: 5,
                          color: AppColors.COLOR_GREY,
                        ),
                        _buildInputForm(),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            widget.loaner.no = no;
                            logger.d(widget.loaner.toJson());
                            Navigator.pop(context);
                          },
                          child: Text('เพิ่มรายการ')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.COLOR_DARK),
            ),
            child: SizedBox(
              height: 200,
              width: 200,
            )),
        label('${widget.loaner.name}'),
        label('Detail: ${widget.loaner.detail}')
      ],
    );
  }

  _buildInputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label("จำนวน"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  no = no - 1;
                  setState(() {});
                },
                icon: Icon(Icons.remove)),
            Text('$no', style: TextStyle(fontSize: 30)),
            IconButton(
              onPressed: () {
                no = no + 1;
                setState(() {});
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        label("หมายเหตุ"),
        TextFormField(
          style: const TextStyle(color: AppColors.COLOR_DARK),
          controller: _controllerdetail,
          decoration:
              inputDecoration(hintText: "หมายเหตุ..."),
          onChanged: (value) {
            widget.loaner.note = value;
            setState(() {});
          },
        )
      ],
    );
  }
}
