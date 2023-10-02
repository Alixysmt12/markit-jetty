import 'dart:convert';

List<QaFailModel> qaFailModelFromJson(String str) => List<QaFailModel>.from(json.decode(str).map((x) => QaFailModel.fromJson(x)));

String qaFailModelToJson(List<QaFailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QaFailModel {
  QaFailModel({
    required this.y,
    required this.label,
  });

  int y;
  String label;

  factory QaFailModel.fromJson(Map<String, dynamic> json) => QaFailModel(
    y: json["y"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "y": y,
    "label": label,
  };
}