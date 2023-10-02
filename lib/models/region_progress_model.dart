
import 'dart:convert';

RegionProgressModel regionProgressModelFromJson(String str) => RegionProgressModel.fromJson(json.decode(str));

String regionProgressModelToJson(RegionProgressModel data) => json.encode(data.toJson());

class RegionProgressModel {
  RegionProgressModel({
    required this.response,
    required this.responsePass,
    required this.responseFail,
  });

  List<ResponseModel> response;
  List<ResponseModel> responsePass;
  List<ResponseModel> responseFail;

  factory RegionProgressModel.fromJson(Map<String, dynamic> json) => RegionProgressModel(
    response: List<ResponseModel>.from(json["response"].map((x) => ResponseModel.fromJson(x))),
    responsePass: List<ResponseModel>.from(json["responsePass"].map((x) => ResponseModel.fromJson(x))),
    responseFail: List<ResponseModel>.from(json["responseFail"].map((x) => ResponseModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
    "responsePass": List<dynamic>.from(responsePass.map((x) => x.toJson())),
    "responseFail": List<dynamic>.from(responseFail.map((x) => x.toJson())),
  };
}

class ResponseModel {
  ResponseModel({
    required this.y,
    required this.label,
  });

  int y;
  String label;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    y: json["y"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "y": y,
    "label": label,
  };
}
