import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/utils/AppColors.dart';

Card appointmentCard( {required List<Color> color,required AppointmentData object,required BuildContext context}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: color[0],
    elevation: 0.5,
    child: InkWell(
        child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColors.COLOR_WHITE,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(object.hospitalName!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Spacer(),
                Container(
                    decoration: BoxDecoration(
                        color: color[1],
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text("o " + object.status!,
                          style: TextStyle(fontSize: 12, color: color[0])),
                    ))
              ],
            ),
            Row(
              children: [
                Text("หน่วยงาน : ",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT)),
                Text(object.organizeName!,
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_BLACK))
              ],
            ),
            Row(
              children: [
                Text("วันที่นัดหมาย : ",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT)),
                Text(object.appDate!,
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_BLACK)),
                SizedBox(width: 10),
                Text("เวลา : ",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT)),
                Text(object.appTime! + " น.",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_BLACK))
              ],
            )
          ]),
        ),
      ),
    )),
  );
}
