import 'dart:convert';

List<QaOverAllModel> qaOverAllModelFromJson(String str) => List<QaOverAllModel>.from(json.decode(str).map((x) => QaOverAllModel.fromJson(x)));

String qaOverAllModelToJson(List<QaOverAllModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QaOverAllModel {
  QaOverAllModel({
   required this.y,
   required this.label,
  });

  int y;
  String label;

  factory QaOverAllModel.fromJson(Map<String, dynamic> json) => QaOverAllModel(
    y: json["y"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "y": y,
    "label": label,
  };
}
