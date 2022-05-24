import 'package:loaner/src/models/loaner/LoanerModel.dart';

class AppointmentDataModel {
  String? id;
  String? supId;
  String? supEmpId;
  String? hospitalId;
  String? hosEmpId;
  String? hosDeptId;
  String? docId;
  String? useDeptId;
  String? patientName;
  String? useDate;
  String? useTime;
  String? appDate;
  String? appTime;
  String? status;
  String? empId;
  List<LoanerModel>? loaners;

  AppointmentDataModel(
      {this.id,
      this.supId,
      this.supEmpId,
      this.hospitalId,
      this.hosEmpId,
      this.hosDeptId,
      this.docId,
      this.useDeptId,
      this.patientName,
      this.useDate,
      this.useTime,
      this.appDate,
      this.appTime,
      this.status,
      this.loaners,
      this.empId});

  AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supId = json['sup_id'];
    supEmpId = json['sup_emp_id'];
    hospitalId = json['hospital_id'];
    hosEmpId = json['hos_emp_id'];
    hosDeptId = json['hos_dept_id'];
    docId = json['doc_id'];
    useDeptId = json['use_dept_id'];
    patientName = json['patient_name'];
    useDate = json['use_date'];
    useTime = json['use_time'];
    appDate = json['app_date'];
    appTime = json['app_time'];
    status = json['status'];
    empId = json['emp_id'];
    if (json['loaner'] != null) {
      loaners = <LoanerModel>[];
      json['loaner'].forEach((v) {
        loaners!.add(new LoanerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sup_id'] = this.supId;
    data['sup_emp_id'] = this.supEmpId;
    data['hospital_id'] = this.hospitalId;
    data['hos_emp_id'] = this.hosEmpId;
    data['hos_dept_id'] = this.hosDeptId;
    data['doc_id'] = this.docId;
    data['use_dept_id'] = this.useDeptId;
    data['patient_name'] = this.patientName;
    data['use_date'] = this.useDate;
    data['use_time'] = this.useTime;
    data['app_date'] = this.appDate;
    data['app_time'] = this.appTime;
    data['status'] = this.status;
    data['emp_id'] = this.empId;
    if (this.loaners != null) {
      data['loaner'] = this.loaners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
