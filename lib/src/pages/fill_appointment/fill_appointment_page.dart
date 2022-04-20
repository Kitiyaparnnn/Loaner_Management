import 'package:flutter/material.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';

class FillAppointmentPage extends StatefulWidget {
  FillAppointmentPage({Key? key}) : super(key: key);

  @override
  State<FillAppointmentPage> createState() => _FillAppointmentPageState();
}

class _FillAppointmentPageState extends State<FillAppointmentPage> {
  final appointment = AppointmentData();
  var _formKey = GlobalKey<FormState>();
  bool isEnabledButtonSave = true;

  String companyName = 'POSE';
  TextEditingController _controllerfirstName =
      new TextEditingController(text: "");
  TextEditingController _controllerlastName =
      new TextEditingController(text: "");
  TextEditingController _controllerdetail = new TextEditingController(text: "");
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
