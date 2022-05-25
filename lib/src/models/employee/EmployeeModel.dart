class EmployeeModel {
  EmployeeModel(
      {this.empId, this.image, this.username, this.detail, this.isTrained});
  String? empId;
  String? image;
  String? username;
  String? detail;
  String? isTrained;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = empId;
    map['username'] = username;
    map['detail'] = detail;
    map['isTrained'] = isTrained;
    map['image'] = image;
    return map;
  }

  EmployeeModel.fromJson(dynamic json) {
    empId = json['empId'];
    username = json['username'];
    detail = json['detail'];
    isTrained = json['isTrained'];
    image = json['image'];
  }
}
