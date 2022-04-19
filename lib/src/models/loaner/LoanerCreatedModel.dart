class LoanerCreatedModel {
  LoanerCreatedModel({this.image, this.name, this.detail, this.no, this.note});

  LoanerCreatedModel.fromJson(dynamic json) {
    image = json['image'];
    name = json['name'];
    detail = json['detail'];
    no = json['no'];
    note = json['note'];
  }

  String? image;
  String? name;
  String? detail;
  int? no;
  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['name'] = name;
    map['detail'] = detail;
    map['note'] = note;
    return map;
  }
}
