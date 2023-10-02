import 'dart:convert';

List<QaPassParseModel> qaPassParseModelFromJson(String str) => List<QaPassParseModel>.from(json.decode(str).map((x) => QaPassParseModel.fromJson(x)));

String qaPassParseModelToJson(List<QaPassParseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QaPassParseModel {
  QaPassParseModel({
    required this.y,
    required this.label,
  });

  int y;
  String label;

  factory QaPassParseModel.fromJson(Map<String, dynamic> json) => QaPassParseModel(
    y: json["y"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "y": y,
    "label": label,
  };
}
