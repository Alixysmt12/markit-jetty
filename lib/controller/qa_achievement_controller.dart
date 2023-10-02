import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/qa_achievement.dart';

import '../models/qa_parse_model.dart';

class QAAchievementController extends GetxController implements GetxService{

  final AQAchievement qAchievement;

  QAAchievementController({required this.qAchievement});

  List<QaAchievementParseModel> _qaAchievementList = [];

  List<QaAchievementParseModel> get qaAchievementList =>
      _qaAchievementList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mQAAchievement(String projectId,String visitMonth,List<String> status) async {
    print("Get token");
    _isLoading = true;
    update();

    Response response = await qAchievement.mQAAchievement(projectId,visitMonth,status);
    late QaAchievementParseModel fieldAchievementModel;
    if (response.statusCode == 200) {
      print("Backend qa Achievement");
      print(response.body);


      _isLoading = false;
      _qaAchievementList = [];

      _qaAchievementList = List.from(response.body).map((e) => QaAchievementParseModel.fromJson(e)).toList();

    } else {
      print('not got qa');
    }
    _isLoading = false;
    update();
  }
}