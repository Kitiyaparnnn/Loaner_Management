class LoginDataUserModel {
  LoginDataUserModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.depName,
      this.depId,
      this.typeId,
      this.image});

  LoginDataUserModel.fromJson(dynamic json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    typeId = json['type_id'];
    depName = json['dep_name'];
    depId = json['dep_id'];
    image = json['image'];
  }
  String? userId;
  String? firstName;
  String? lastName;
  String? typeId;
  String? depId;
  String? depName;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['type_id'] = typeId;
    map['dep_name'] = depName;
    map['dep_id'] = depId;
    map['image'] = image;
    return map;
  }
}
