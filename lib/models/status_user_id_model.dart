
import 'dart:convert';

List<StatusUserIdModel> statusUserIdModelFromJson(String str) => List<StatusUserIdModel>.from(json.decode(str).map((x) => StatusUserIdModel.fromJson(x)));

String statusUserIdModelToJson(List<StatusUserIdModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatusUserIdModel {
  StatusUserIdModel({
    required this.total,
    required this.pending,
    required this.pass,
    required this.fail,
    required this.name,
  });

  int total;
  String pending;
  String pass;
  String fail;
  String name;

  factory StatusUserIdModel.fromJson(Map<String, dynamic> json) => StatusUserIdModel(
    total: json["Total"],
    pending: json["Pending"],
    pass: json["Pass"],
    fail: json["Fail"],
    name: json["NAME"],
  );

  Map<String, dynamic> toJson() => {
    "Total": total,
    "Pending": pending,
    "Pass": pass,
    "Fail": fail,
    "NAME": name,
  };
}
