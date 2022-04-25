import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/LabelFormat.dart';
import 'package:loaner/src/utils/MyAppBar.dart';

class LoanerSumPage extends StatefulWidget {
  LoanerSumPage({this.selectedLoaner});
  List<LoanerModel>? selectedLoaner;
  @override
  State<LoanerSumPage> createState() => _LoanerSumPageState();
}

class _LoanerSumPageState extends State<LoanerSumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: Constants.LOANER_SUM_TITLE, context: context),
      body: widget.selectedLoaner!.length != 0
          ? ListView.builder(
              itemCount: widget.selectedLoaner!.length,
              itemBuilder: ((context, index) =>
                  _mapList(widget.selectedLoaner!, index)),
            )
          : Center(child: Text(Constants.TEXT_DATA_NOT_FOUND)),
      bottomNavigationBar: _bottomButton(),
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
              if (widget.selectedLoaner != null) {
                logger.d(widget.selectedLoaner![1].toJson());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppointmentPage()));
              }
            } catch (e) {
              BotToast.showText(text: Constants.TEXT_FORM_FIELD);
            }
          },
          child: Text("บันทึก", style: TextStyle(fontSize: 16))),
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
                      IconButton(
                          splashRadius: 10.0,
                          highlightColor: AppColors.COLOR_PRIMARY,
                          onPressed: () {
                            object[index].rent = object[index].rent! - 1;
                            setState(() {});
                          },
                          icon: Icon(Icons.remove)),
                      Text("${object[index].rent}",
                          style: TextStyle(fontSize: 21)),
                      IconButton(
                        splashRadius: 10.0,
                        highlightColor: AppColors.COLOR_PRIMARY,
                        onPressed: () {
                          object[index].rent = object[index].rent! + 1;
                          setState(() {});
                        },
                        icon: Icon(Icons.add),
                      )
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
                  label("หมายเหตุ*"),
                  Text(object[index].detail!,
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
