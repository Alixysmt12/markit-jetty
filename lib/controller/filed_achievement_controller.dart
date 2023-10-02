import 'dart:convert';

import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/field_achievement_repo.dart';
import 'package:markit_jetty/models/field_achievement_model_perse_json.dart';
import 'package:markit_jetty/models/field_achievment_model.dart';

import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';

class FieldAchievementController extends GetxController implements GetxService {


  final FieldAchievement fieldAchievementrepo;

  FieldAchievementController({required this.fieldAchievementrepo});

  // List<dynamic> _fieldAchievementList = [];
  //List<dynamic> get fieldAchievementList => _fieldAchievementList;

  List<FieldAchievementParseModel> _fieldAchievementList = [];

  List<FieldAchievementParseModel> get fieldAchievementList =>
      _fieldAchievementList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fieldAchievementData(String projectId,String visitMonth,List<String> status) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response = await fieldAchievementrepo.fieldAchievement(projectId,visitMonth,status);
    late FieldAchievementModel fieldAchievementModel;
    if (response.statusCode == 200) {
      print("Backend fieldAchievement hello");
      print(response.body);

      /*_fieldAchievementList = [];
      _fieldAchievementList.addAll(List.from(response.body)
          .map((e) => FieldAchievementModel.fromJson(e)));
      _fieldAchievementList;*/
      _fieldAchievementList = [];

    //  _fieldAchievementList = fieldAchievementParseModelFromJson(response.body);

    //  _fieldAchievementList = jsonDecode(response.body);

      _fieldAchievementList = List.from(response.body).map((e) => FieldAchievementParseModel.fromJson(e)).toList();

    } else {
      print('not got field achieve');
    }
    _isLoading = false;
    update();
  }
}
