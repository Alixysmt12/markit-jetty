import 'dart:convert';

List<SyncWiseModel> syncWiseModelFromJson(String str) => List<SyncWiseModel>.from(json.decode(str).map((x) => SyncWiseModel.fromJson(x)));

String syncWiseModelToJson(List<SyncWiseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SyncWiseModel {
  SyncWiseModel({
    required this.total,
    required this.syncDate,
    required this.subTotal,
  });

  int total;
  DateTime syncDate;
  int subTotal;

  factory SyncWiseModel.fromJson(Map<String, dynamic> json) => SyncWiseModel(
    total: json["Total"],
    syncDate: DateTime.parse(json["syncDate"]),
    subTotal: json["subTotal"],
  );

  Map<String, dynamic> toJson() => {
    "Total": total,
    "syncDate": "${syncDate.year.toString().padLeft(4, '0')}-${syncDate.month.toString().padLeft(2, '0')}-${syncDate.day.toString().padLeft(2, '0')}",
    "subTotal": subTotal,
  };
}
