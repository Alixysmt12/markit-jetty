
import 'dart:convert';

List<BatchPassingModel> batchPassingModelFromJson(String str) => List<BatchPassingModel>.from(json.decode(str).map((x) => BatchPassingModel.fromJson(x)));

String batchPassingModelToJson(List<BatchPassingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatchPassingModel {
  BatchPassingModel({
    required this.batchPassingPercentage,
  });

  int batchPassingPercentage;

  factory BatchPassingModel.fromJson(Map<String, dynamic> json) => BatchPassingModel(
    batchPassingPercentage: json["batchPassingPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "batchPassingPercentage": batchPassingPercentage,
  };
}
