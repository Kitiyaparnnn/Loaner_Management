class LoanerModel {
  LoanerModel(
      {this.image,
      this.itemCode,
      this.name,
      this.detail,
      this.rent,
      this.note,
      this.isActive,
      this.id});

  LoanerModel.fromJson(dynamic json) {
    id = json['id'];
    itemCode = json['item_code'];
    image = json['image'];
    name = json['name'];
    detail = json['detail'];
    rent = json['rent'];
    note = json['note'];
    isActive = json['is_active'];
  }
  String? id;
  String? itemCode;
  String? image;
  String? name;
  String? detail;
  int? rent;
  String? note;
  String? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['item_code'] = itemCode;
    map['image'] = image;
    map['name'] = name;
    map['detail'] = detail;
    map['rent'] = rent;
    map['note'] = note;
    map['is_active'] = isActive;
    return map;
  }
}
