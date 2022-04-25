class LoanerModel {
  LoanerModel({this.group,this.image, this.name, this.detail, this.rent, this.note});

  LoanerModel.fromJson(dynamic json) {
    group = json['group'];
    image = json['image'];
    name = json['name'];
    detail = json['detail'];
    rent = json['rent'];
    note = json['note'];
  }

  String? group;
  String? image;
  String? name;
  String? detail;
  int? rent;

  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group'] = group;
    map['image'] = image;
    map['name'] = name;
    map['detail'] = detail;
    map['rent'] = rent;
    map['note'] = note;
    return map;
  }
}
