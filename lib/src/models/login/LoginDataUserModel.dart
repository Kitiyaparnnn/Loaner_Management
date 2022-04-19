class LoginDataUserModel {
  LoginDataUserModel({
      this.userId, 
      this.empCode, 
      this.firstName, 
      this.lastName, 
      this.depId, 
      this.depName,});

  LoginDataUserModel.fromJson(dynamic json) {
    userId = json['user_id'];
    empCode = json['emp_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    depId = json['dep_id'];
    depName = json['dep_name'];
  }
  String? userId;
  String? empCode;
  String? firstName;
  String? lastName;
  String? depId;
  String? depName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['emp_code'] = empCode;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['dep_id'] = depId;
    map['dep_name'] = depName;
    return map;
  }

}