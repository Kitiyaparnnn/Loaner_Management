class EmployeeDataModel {
  EmployeeDataModel(
      {this.empId,
      this.userCode,
      this.type,
      this.deptId,
      this.prefix,
      this.firstName,
      this.lastName,
      this.detail,
      this.isTrained,
      this.image,
      this.isActive,
      this.username,
      this.password});

  String? empId;
  String? userCode;
  String? type;
  String? deptId;
  String? prefix;
  String? firstName;
  String? lastName;
  String? detail;
  String? isTrained;
  String? image;
  String? isActive;
  String? username;
  String? password;

  EmployeeDataModel.fromJson(dynamic json) {
    empId = json['empId'];
    userCode = json['user_code'];
    type = json['type'];
    deptId = json['deptId'];
    prefix = json['prefix'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    detail = json['detail'];
    isTrained = json['is_trained'];
    image = json['image'];
    isActive = json['is_active'];
    username = json['user_name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = empId;
    map['user_code'] = userCode;
    map['type'] = type;
    map['deptId'] = deptId;
    map['prefix'] = prefix;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['detail'] = detail;
    map['is_trained'] = isTrained;
    map['image'] = image;
    map['is_active'] = isActive;
    map['user_name'] = username;
    map['password'] = password;
    return map;
  }
}
