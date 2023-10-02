import 'package:get/get.dart';
import 'package:markit_jetty/models/firsr_day_achievement.dart';

import '../data/repository/first_day_repo.dart';

class FirstDayController extends GetxController implements GetxService{


  final FirstDayRepo firstDayRepo;

  FirstDayController({required this.firstDayRepo});

  // List<dynamic> _fieldAchievementList = [];
  //List<dynamic> get fieldAchievementList => _fieldAchievementList;

  List<FirstDayAchievementModel> _firstDayAchievementList = [];

  List<FirstDayAchievementModel> get firstDayAchievementList =>
      _firstDayAchievementList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fieldAchievementData(String id,String visitMonth,String projectClassification) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response = await firstDayRepo.firstDay(id,visitMonth,projectClassification);
    late FirstDayAchievementModel fieldAchievementModel;

    if (response.statusCode == 200) {
      print("Backend fieldAchievement checking");
      print(response.body);

      /*_fieldAchievementList = [];
      _fieldAchievementList.addAll(List.from(response.body)
          .map((e) => FieldAchievementModel.fromJson(e)));
      _fieldAchievementList;*/
      _firstDayAchievementList = [];

      //  _fieldAchievementList = fieldAchievementParseModelFromJson(response.body);

      //  _fieldAchievementList = jsonDecode(response.body);

      if(response.body != null && response.bodyString != "[]" && response.body != 0) {
        _firstDayAchievementList = List.from(response.body)
            .map((e) => FirstDayAchievementModel.fromJson(e))
            .toList();
      }
    } else {
      print('not first day achievement');
    }
    _isLoading = false;
    update();
  }

}