
import 'dart:convert';

List<OneOffWaveModel> oneOffWaveModelFromJson(String str) => List<OneOffWaveModel>.from(json.decode(str).map((x) => OneOffWaveModel.fromJson(x)));

String oneOffWaveModelToJson(List<OneOffWaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OneOffWaveModel {
  OneOffWaveModel({
    required this.id,
    required this.name,
    required this.fieldStartDate,
    required this.fieldEndDate,
    required this.fieldCutOffDate,
    required this.qaCutOffDate,
    required this.studyType,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
  });

  int id;
  String name;
  DateTime fieldStartDate;
  DateTime fieldEndDate;
  DateTime fieldCutOffDate;
  DateTime qaCutOffDate;
  String studyType;
  bool isActive;
  int createdBy;
  int updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  int projectId;

  factory OneOffWaveModel.fromJson(Map<String, dynamic> json) => OneOffWaveModel(
    id: json["id"],
    name: json["name"],
    fieldStartDate: DateTime.parse(json["fieldStartDate"]),
    fieldEndDate: DateTime.parse(json["fieldEndDate"]),
    fieldCutOffDate: DateTime.parse(json["fieldCutOffDate"]),
    qaCutOffDate: DateTime.parse(json["qaCutOffDate"]),
    studyType: json["studyType"],
    isActive: json["isActive"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    projectId: json["projectId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "fieldStartDate": "${fieldStartDate.year.toString().padLeft(4, '0')}-${fieldStartDate.month.toString().padLeft(2, '0')}-${fieldStartDate.day.toString().padLeft(2, '0')}",
    "fieldEndDate": "${fieldEndDate.year.toString().padLeft(4, '0')}-${fieldEndDate.month.toString().padLeft(2, '0')}-${fieldEndDate.day.toString().padLeft(2, '0')}",
    "fieldCutOffDate": "${fieldCutOffDate.year.toString().padLeft(4, '0')}-${fieldCutOffDate.month.toString().padLeft(2, '0')}-${fieldCutOffDate.day.toString().padLeft(2, '0')}",
    "qaCutOffDate": "${qaCutOffDate.year.toString().padLeft(4, '0')}-${qaCutOffDate.month.toString().padLeft(2, '0')}-${qaCutOffDate.day.toString().padLeft(2, '0')}",
    "studyType": studyType,
    "isActive": isActive,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "projectId": projectId,
  };
}
