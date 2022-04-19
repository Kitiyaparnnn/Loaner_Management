class AppointmentCreatedModel {
  AppointmentCreatedModel({this.appNo, this.status});

  AppointmentCreatedModel.fromJson(dynamic json) {
    appNo = json['app_no'];
    status = json['status'];
  }
  String? appNo;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_no'] = appNo;
    map['status'] = status;
    return map;
  }
}
