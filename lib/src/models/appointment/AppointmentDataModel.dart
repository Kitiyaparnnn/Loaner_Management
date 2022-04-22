class AppointmentData {
  AppointmentData(
      {this.companyName,
      this.empName,
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
      this.status});

  AppointmentData.fromJson(dynamic json) {
    companyName = json['company_name'];
    empName = json['emp_name'];
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
  }

  String? companyName;
  String? empName;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['company_name'] = companyName;
    map['emp_name'] = empName;
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
    return map;
  }
}
