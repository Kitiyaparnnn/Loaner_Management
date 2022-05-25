import 'package:loaner/src/models/loaner/LoanerModel.dart';

class AppointmentModel {
  String? id;
  String? supEmpName;
  String? supName;
  String? hospitalName;
  String? hosEmpName;
  String? hosDeptName;
  String? docName;
  String? useDeptName;
  String? patientName;
  String? useDate;
  String? useTime;
  String? appDate;
  String? appTime;
  String? status;
  List<LoanerModel>? loaner;

  AppointmentModel(
      {this.id,
      this.supEmpName,
      this.supName,
      this.hospitalName,
      this.hosEmpName,
      this.hosDeptName,
      this.docName,
      this.useDeptName,
      this.patientName,
      this.useDate,
      this.useTime,
      this.appDate,
      this.appTime,
      this.status,
      this.loaner});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supEmpName = json['sup_emp_name'];
    supName = json['sup_name'];
    hospitalName = json['hospital_name'];
    hosEmpName = json['hos_emp_name'];
    hosDeptName = json['hos_dept_name'];
    docName = json['doc_name'];
    useDeptName = json['use_dept_name'];
    patientName = json['patient_name'];
    useDate = json['use_date'];
    useTime = json['use_time'];
    appDate = json['app_date'];
    appTime = json['app_time'];
    status = json['status'];
    if (json['loaner'] != null) {
      loaner = <LoanerModel>[];
      json['loaner'].forEach((v) {
        loaner!.add(new LoanerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sup_emp_name'] = this.supEmpName;
    data['sup_name'] = this.supName;
    data['hospital_name'] = this.hospitalName;
    data['hos_emp_name'] = this.hosEmpName;
    data['hos_dept_name'] = this.hosDeptName;
    data['doc_name'] = this.docName;
    data['use_dept_name'] = this.useDeptName;
    data['patient_name'] = this.patientName;
    data['use_date'] = this.useDate;
    data['use_time'] = this.useTime;
    data['app_date'] = this.appDate;
    data['app_time'] = this.appTime;
    data['status'] = this.status;
    if (this.loaner != null) {
      data['loaner'] = this.loaner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
