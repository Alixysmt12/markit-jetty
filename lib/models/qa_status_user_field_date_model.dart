
import 'dart:convert';

List<StatusUserFieldDateModel> statusUserFieldDateModelFromJson(String str) => List<StatusUserFieldDateModel>.from(json.decode(str).map((x) => StatusUserFieldDateModel.fromJson(x)));

String statusUserFieldDateModelToJson(List<StatusUserFieldDateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusUserFieldDateModel {
  StatusUserFieldDateModel({
    required this.total,
    required this.pending,
    required this.pass,
    required this.fail,
    required this.fieldDate,
  });

  int total;
  String pending;
  String pass;
  String fail;
  DateTime fieldDate;

  factory StatusUserFieldDateModel.fromJson(Map<String, dynamic> json) => StatusUserFieldDateModel(
    total: json["Total"],
    pending: json["Pending"],
    pass: json["Pass"],
    fail: json["Fail"],
    fieldDate: DateTime.parse(json["fieldDate"]),
  );

  Map<String, dynamic> toJson() => {
    "Total": total,
    "Pending": pending,
    "Pass": pass,
    "Fail": fail,
    "fieldDate": "${fieldDate.year.toString().padLeft(4, '0')}-${fieldDate.month.toString().padLeft(2, '0')}-${fieldDate.day.toString().padLeft(2, '0')}",
  };
}
