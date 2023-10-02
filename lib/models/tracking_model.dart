import 'dart:convert';

List<TrackingModel> trackingRepoFromJson(String str) => List<TrackingModel>.from(json.decode(str).map((x) => TrackingModel.fromJson(x)));

String trackingRepoToJson(List<TrackingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrackingModel {
  TrackingModel({
    required this.id,
    required this.name,
    required this.currentWave,
    required this.waveStartDate,
    required this.waveEndDate,
    required this.fieldCutOffDate,
    required this.qaCutOffDate,
  });

  int id;
  String name;
  bool currentWave;
  DateTime waveStartDate;
  DateTime waveEndDate;
  DateTime fieldCutOffDate;
  DateTime qaCutOffDate;

  factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
    id: json["id"],
    name: json["name"],
    currentWave: json["currentWave"],
    waveStartDate: DateTime.parse(json["waveStartDate"]),
    waveEndDate: DateTime.parse(json["waveEndDate"]),
    fieldCutOffDate: DateTime.parse(json["fieldCutOffDate"]),
    qaCutOffDate: DateTime.parse(json["qaCutOffDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "currentWave": currentWave,
    "waveStartDate": "${waveStartDate.year.toString().padLeft(4, '0')}-${waveStartDate.month.toString().padLeft(2, '0')}-${waveStartDate.day.toString().padLeft(2, '0')}",
    "waveEndDate": "${waveEndDate.year.toString().padLeft(4, '0')}-${waveEndDate.month.toString().padLeft(2, '0')}-${waveEndDate.day.toString().padLeft(2, '0')}",
    "fieldCutOffDate": "${fieldCutOffDate.year.toString().padLeft(4, '0')}-${fieldCutOffDate.month.toString().padLeft(2, '0')}-${fieldCutOffDate.day.toString().padLeft(2, '0')}",
    "qaCutOffDate": "${qaCutOffDate.year.toString().padLeft(4, '0')}-${qaCutOffDate.month.toString().padLeft(2, '0')}-${qaCutOffDate.day.toString().padLeft(2, '0')}",
  };
}
