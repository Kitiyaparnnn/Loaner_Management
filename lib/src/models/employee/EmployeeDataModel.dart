class EmployeeDataModel {
  EmployeeDataModel(
      {this.empId,
      this.companyName,
      this.headName,
      this.firstName,
      this.lastName,
      this.detail,
      this.isTrained,
      this.image});
  String? empId;
  String? companyName;
  String? headName;
  String? firstName;
  String? lastName;
  String? detail;
  bool? isTrained;
  String? image;

  EmployeeDataModel.fromJson(dynamic json) {
    empId = json['empId'];
    companyName = json['company_name'];
    headName = json['head_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    detail = json['detail'];
    isTrained = json['isTrained'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = empId;
    map['company_name'] = companyName;
    map['head_name'] = headName;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['detail'] = detail;
    map['isTrained'] = isTrained;
    map['image'] = image;
    return map;
  }

  String username() {
    return firstName! + lastName!;
  }
}
