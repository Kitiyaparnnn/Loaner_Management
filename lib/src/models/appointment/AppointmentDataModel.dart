import 'package:loaner/src/models/loaner/LoanerModel.dart';

//create&update input id
//get detail output name
class AppointmentDataModel {
  AppointmentDataModel(
      {
      this.id,
      this.supId,
      this.supEmpId,
      this.hosId,
      this.hosDeptId,
      this.hosEmpId,
      this.docId,
      this.userDeptId,
      this.patientName,
      this.useDate,
      this.useTime,
      this.appDate,
      this.appTime,
      this.status,
      this.loaners});

  AppointmentDataModel.fromJson(dynamic json) {
    id = json['id'];
    supId = json['sup_id'];
    supEmpId = json['sup_emp_id'];
    hosId = json['hospital_id'];
    hosDeptId = json['hos_dept_id'];
    hosEmpId = json['hos_emp_id'];
    docId = json['doc_id'];
    userDeptId = json['user_dept_id'];
    patientName = json['patient_name'];
    useDate = json['use_date'];
    useTime = json['use_time'];
    appTime = json['app_time'];
    appDate = json['app_date'];
    status = json['status'];
    loaners = json['loaners'];
  }

  String? id;
  String? supId;
  String? supEmpId; 
  String? hosId;
  String? hosDeptId;
  String? hosEmpId;
  String? docId;
  String? userDeptId;
  String? patientName;
  String? useDate;
  String? useTime;
  String? appDate;
  String? appTime;
  String? status;
  List<LoanerModel>? loaners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sup_id'] = supId;
    map['sup_emp_id'] = supEmpId;
    map['hospital_id'] = hosId;
    map['hos_dept_id'] = hosDeptId;
    map['hos_emp_id'] = hosEmpId;
    map['doc_id'] = docId;
    map['user_dept_id'] = userDeptId;
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
