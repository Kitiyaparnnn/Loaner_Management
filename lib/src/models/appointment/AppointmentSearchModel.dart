class AppointmentSearchModel {
  AppointmentSearchModel({this.status,this.hospital,this.date});

  AppointmentSearchModel.fromJson(dynamic json) {
    status = json['status'];
    hospital = json['hospital'];
    date = json['date'];
  }
  String? hospital;
  String? status;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['hospital'] = hospital;
    map['date'] = date;
    return map;
  }
}
