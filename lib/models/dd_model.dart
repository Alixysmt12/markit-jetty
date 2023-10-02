import 'dart:convert';

List<DdModel> ddModelFromJson(String str) =>
    List<DdModel>.from(json.decode(str).map((x) => DdModel.fromJson(x)));

String ddModelToJson(List<DdModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DdModel {
  DdModel({
    required this.id,
    required this.pageName,
    required this.actions,
  });

  int id;
  String pageName;
  String actions;

  factory DdModel.fromJson(Map<String, dynamic> json) => DdModel(
        id: json["id"],
        pageName: json["pageName"],
        actions: json["actions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageName": pageName,
        "actions": actions,
      };
}
