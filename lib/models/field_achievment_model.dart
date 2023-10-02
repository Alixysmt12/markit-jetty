class FieldAchievementModel {
  int? total;
  String? fieldDate;
  int? subTotal;

  FieldAchievementModel({this.total, this.fieldDate, this.subTotal});

  FieldAchievementModel.fromJson(Map<String, dynamic> json) {
    total = json['Total'];
    fieldDate = json['fieldDate'];
    subTotal = json['subTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total'] = this.total;
    data['fieldDate'] = this.fieldDate;
    data['subTotal'] = this.subTotal;
    return data;
  }
}