import 'dart:convert';

List<QaPassModel> qaPassModelFromJson(String str) => List<QaPassModel>.from(json.decode(str).map((x) => QaPassModel.fromJson(x)));

String qaPassModelToJson(List<QaPassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QaPassModel {
  QaPassModel({
   required this.y,
   required this.label,
  });

  int y;
  String label;

  factory QaPassModel.fromJson(Map<String, dynamic> json) => QaPassModel(
    y: json["y"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "y": y,
    "label": label,
  };
}
