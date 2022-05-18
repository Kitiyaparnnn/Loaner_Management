class LoanerDataModel {
  LoanerDataModel({
    this.id,
    this.type,
    this.image,
    this.name,
    this.detail,
    this.qty,
    this.size
  });

  LoanerDataModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    name = json['name'];
    detail = json['detail'];
    qty = json['qty'];
    size = json['size'];
  }

  String? id;
  String? type;
  String? image;
  String? name;
  String? detail;
  String? qty;
  String? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['image'] = image;
    map['name'] = name;
    map['detail'] = detail;
    map['qty'] = qty;
    map['size'] = size;

    return map;
  }
}
