import 'dart:convert';

List<FieldAchievementParseModel> fieldAchievementParseModelFromJson(String str) => List<FieldAchievementParseModel>.from(json.decode(str).map((x) => FieldAchievementParseModel.fromJson(x)));

String fieldAchievementParseModelToJson(List<FieldAchievementParseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FieldAchievementParseModel {
  FieldAchievementParseModel({
    required this.total,
    required this.fieldDate,
    required this.subTotal,
  });

  int total;
  DateTime fieldDate;
  int subTotal;

  factory FieldAchievementParseModel.fromJson(Map<String, dynamic> json) => FieldAchievementParseModel(
    total: json["Total"],
    fieldDate: DateTime.parse(json["fieldDate"]),
    subTotal: json["subTotal"],
  );

  Map<String, dynamic> toJson() => {
    "Total": total,
    "fieldDate": "${fieldDate.year.toString().padLeft(4, '0')}-${fieldDate.month.toString().padLeft(2, '0')}-${fieldDate.day.toString().padLeft(2, '0')}",
    "subTotal": subTotal,
  };
}
