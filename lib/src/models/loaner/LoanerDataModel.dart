class LoanerDataModel {
  LoanerDataModel({
    this.id,
    this.group,
    this.image,
    this.name,
    this.detail,
    this.stock,
  });

  LoanerDataModel.fromJson(dynamic json) {
    id = json['id'];
    group = json['group'];
    image = json['image'];
    name = json['name'];
    detail = json['detail'];
    stock = json['stock'];
  }
  String? id;

  String? group;
  String? image;
  String? name;
  String? detail;
  String? stock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group'] = group;
    map['image'] = image;
    map['name'] = name;
    map['detail'] = detail;
    map['stock'] = stock;

    return map;
  }
}
