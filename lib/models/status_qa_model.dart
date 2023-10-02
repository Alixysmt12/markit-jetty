import 'dart:convert';

QaStatusParseModel qaStatusParseModelFromJson(String str) =>
    QaStatusParseModel.fromJson(json.decode(str));

String qaStatusParseModelToJson(QaStatusParseModel data) =>
    json.encode(data.toJson());

class QaStatusParseModel {
  QaStatusParseModel({
    //required this.lastDayQa,
    required this.fail,
    required this.pass,
    required this.total,
  });

  //int lastDayQa;
  int? fail;
  int? pass;
  int? total;

  factory QaStatusParseModel.fromJson(Map<String, dynamic> json) =>
      QaStatusParseModel(
        //lastDayQa: json["LastDayQA"],
        fail: json["Fail"],
        pass: json["Pass"],
        total: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        //"LastDayQA": lastDayQa,
        "Fail": fail,
        "Pass": pass,
        "Total": total,
      };
}
