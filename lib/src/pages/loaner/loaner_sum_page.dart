import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AskForConfirmToSave.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';

class LoanerSumPage extends StatefulWidget {
  LoanerSumPage({required this.isEdit});
  bool isEdit;
  @override
  State<LoanerSumPage> createState() => _LoanerSumPageState();
}

class _LoanerSumPageState extends State<LoanerSumPage> {
  List<LoanerModel> loaners = [];
  String appStatus = "0";

  @override
  void initState() {
    context.read<AppointmentBloc>().add(AppointmentGetLoaner());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: Constants.LOANER_SUM_TITLE),
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentStateGetLoaner) {
            loaners = state.loaners;
          }
          return loaners.length != 0
              ? ListView.builder(
                  itemCount: loaners.length,
                  itemBuilder: ((context, index) => _mapList(loaners, index)),
                )
              : Center(child: Text(Constants.TEXT_DATA_NOT_FOUND));
        },
      ),
      bottomNavigationBar: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentStateGetLoaner) {
            appStatus = state.status;
          }
          return appStatus == "0" ? _bottomButton() : SizedBox(height: 10);
        },
      ),
    );
  }

  _bottomButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              primary: AppColors.COLOR_PRIMARY),
          onPressed: () {
            try {
              askForConfirmToSave(context: context, isSupplier: true);
              context
                  .read<AppointmentBloc>()
                  .add(AppointmentButtonOnPress2(isEdit: widget.isEdit));
            } catch (e) {
              logger.e(e);
              BotToast.showText(text: Constants.TEXT_FORM_FIELD);
            }
          },
          child: Text(widget.isEdit ? "แก้ไขข้อมูล" : "บันทึก",
              style: TextStyle(fontSize: 16))),
    );
  }

  _mapList(List<LoanerModel> object, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.COLOR_WHITE,
        elevation: 0.0,
        child: Column(
          children: [
            ListTile(
              leading: SizedBox(
                height: 60,
                width: 60,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.COLOR_GREY,
                      border:
                          Border.all(color: AppColors.COLOR_GREY, width: 2.0)),
                  child: object[index].image != null ? null : Icon(Icons.image),
                ),
              ),
              title: Text(object[index].name!, style: TextStyle(fontSize: 16)),
              subtitle: Text(
                object[index].detail!,
                style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text("จำนวน",
                      style: TextStyle(
                          fontSize: 14, color: AppColors.COLOR_BLACK)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appStatus == "0"
                          ? InkWell(
                              onTap: () {
                                context
                                    .read<AppointmentBloc>()
                                    .add(AppointmentMinusLoaner(index: index));
                              },
                              child: Image.asset(
                                  "${Constants.IMAGE_DIR}/minus.png"))
                          : SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text("${object[index].rent}",
                            style: TextStyle(fontSize: 21)),
                      ),
                      appStatus == "0"
                          ? InkWell(
                              onTap: () {
                                context
                                    .read<AppointmentBloc>()
                                    .add(AppointmentPlusLoaner(index: index));
                              },
                              child: Image.asset(
                                  "${Constants.IMAGE_DIR}/plus.png"),
                            )
                          : SizedBox(height: 10)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: AppColors.COLOR_GREY,
                    thickness: 2.0,
                  ),
                  Row(children: [
                    Text("หมายเหตุ",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.COLOR_BLACK)),
                    Text("*",
                        style:
                            TextStyle(fontSize: 14, color: AppColors.COLOR_RED))
                  ]),
                  Text(object[index].note!,
                      style:
                          TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
