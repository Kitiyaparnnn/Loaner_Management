class LoginDataUserModel {
  LoginDataUserModel(
      {this.userId,
      this.empCode,
      this.firstName,
      this.lastName,
      this.depId,
      this.depName,
      this.companyName});

  LoginDataUserModel.fromJson(dynamic json) {
    userId = json['user_id'];
    empCode = json['emp_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    depId = json['dep_id'];
    depName = json['dep_name'];
    companyName = json['company_name'];
  }
  String? userId;
  String? empCode;
  String? firstName;
  String? lastName;
  String? depId;
  String? depName;
  String? companyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['emp_code'] = empCode;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['dep_id'] = depId;
    map['dep_name'] = depName;
    map['company_name'] = companyName;
    return map;
  }
}
