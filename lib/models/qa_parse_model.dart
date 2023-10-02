import 'dart:convert';

List<QaAchievementParseModel> qaAchievementParseModelFromJson(String str) => List<QaAchievementParseModel>.from(json.decode(str).map((x) => QaAchievementParseModel.fromJson(x)));

String qaAchievementParseModelToJson(List<QaAchievementParseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QaAchievementParseModel {
  QaAchievementParseModel({
    required this.total,
    required this.qaDate,
    required this.subTotal,
  });

  int total;
  DateTime qaDate;
  int subTotal;

  factory QaAchievementParseModel.fromJson(Map<String, dynamic> json) => QaAchievementParseModel(
    total: json["Total"],
    qaDate: DateTime.parse(json["QADate"]),
    subTotal: json["subTotal"],
  );

  Map<String, dynamic> toJson() => {
    "Total": total,
    "QADate": "${qaDate.year.toString().padLeft(4, '0')}-${qaDate.month.toString().padLeft(2, '0')}-${qaDate.day.toString().padLeft(2, '0')}",
    "subTotal": subTotal,
  };
}
