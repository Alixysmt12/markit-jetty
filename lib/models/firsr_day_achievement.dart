import 'dart:convert';

List<FirstDayAchievementModel> firstDayAchievementModelFromJson(String str) => List<FirstDayAchievementModel>.from(json.decode(str).map((x) => FirstDayAchievementModel.fromJson(x)));

String firstDayAchievementModelToJson(List<FirstDayAchievementModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FirstDayAchievementModel {
  FirstDayAchievementModel({
   required this.totalAchievement,
   required this.totalQaAchievement,
   required this.pass,
   required this.fail,
  });

  int? totalAchievement;
  int? totalQaAchievement;
  int? pass;
  int? fail;

  factory FirstDayAchievementModel.fromJson(Map<String, dynamic> json) => FirstDayAchievementModel(
    totalAchievement: json["TotalAchievement"],
    totalQaAchievement: json["TotalQAAchievement"],
    pass: json["Pass"],
    fail: json["Fail"],
  );

  Map<String, dynamic> toJson() => {
    "TotalAchievement": totalAchievement,
    "TotalQAAchievement": totalQaAchievement,
    "Pass": pass,
    "Fail": fail,
  };
}
