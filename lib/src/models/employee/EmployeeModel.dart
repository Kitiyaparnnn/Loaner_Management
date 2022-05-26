class EmployeeModel {
  EmployeeModel(
      {this.id,
      this.image,
      this.username,
      this.detail,
      this.isTrained,
      this.isActive});

  String? id;
  String? image;
  String? username;
  String? detail;
  String? isTrained;
  String? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empId'] = id;
    map['username'] = username;
    map['detail'] = detail;
    map['isTrained'] = isTrained;
    map['image'] = image;
    map['is_active'] = isActive;
    return map;
  }

  EmployeeModel.fromJson(dynamic json) {
    id = json['empId'];
    username = json['username'];
    detail = json['detail'];
    isTrained = json['isTrained'];
    image = json['image'];
    isActive = json['is_active'];
  }
}
