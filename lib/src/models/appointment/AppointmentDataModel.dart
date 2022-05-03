import 'package:loaner/src/models/loaner/LoanerModel.dart';

class AppointmentDataModel {
  AppointmentDataModel(
      {this.appNo,
      this.companyName,
      this.empId,
      this.hospitalName,
      this.organizeName,
      this.cssdName,
      this.docName,
      this.depName,
      this.patientName,
      this.useDate,
      this.useTime,
      this.appDate,
      this.appTime,
      this.status,
      this.loaners});

  AppointmentDataModel.fromJson(dynamic json) {
    appNo = json['appNo'];
    companyName = json['company_name'];
    empId = json['empId'];
    hospitalName = json['hospital_name'];
    organizeName = json['organize_name'];
    cssdName = json['cssd_name'];
    docName = json['doc_name'];
    depName = json['dep_name'];
    patientName = json['patient_name'];
    useDate = json['use_date'];
    useTime = json['use_time'];
    appTime = json['app_time'];
    appDate = json['app_date'];
    status = json['status'];
    loaners = json['loaners'];
  }

  String? appNo;
  String? companyName;
  String? empId; 
  String? hospitalName;
  String? organizeName;
  String? cssdName;
  String? docName;
  String? depName;
  String? patientName;
  String? useDate;
  String? useTime;
  String? appDate;
  String? appTime;
  String? status;
  List<LoanerModel>? loaners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appNo'] = appNo;
    map['company_name'] = companyName;
    map['empId'] = empId;
    map['hospital_name'] = hospitalName;
    map['organize_name'] = organizeName;
    map['cssd_name'] = cssdName;
    map['doc_name'] = docName;
    map['dep_name'] = depName;
    map['patient_name'] = patientName;
    map['use_date'] = useDate;
    map['use_time'] = useTime;
    map['app_date'] = appDate;
    map['app_time'] = appTime;
    map['status'] = status;
    map['loaners'] = loaners!.map((e) => e.toJson());
    return map;
  }
}
