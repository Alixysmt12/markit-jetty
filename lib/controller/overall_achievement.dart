import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/overall_repo.dart';

import '../models/qa_overall.dart';
import '../models/qa_pase_model_pass.dart';

class OverAllAchievementController extends GetxController
    implements GetxService {
  final OverallRepo overallRepo;

  OverAllAchievementController({required this.overallRepo});

  List<QaOverAllModel> _qaPassList = [];

  List<QaOverAllModel> get qaPassList => _qaPassList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> mOverAllAchievement(
      String id, String visitMonth, String quotaStatus) async {
    print("OverAll");
    _isLoading = true;
    update();

    Response response =
        await overallRepo.mQOverall(id, visitMonth, quotaStatus);
    late QaPassParseModel fieldAchievementModel;
    if (response.statusCode == 200) {
      print("Backend qa Achievement");
      print(response.body);

      _qaPassList = [];

      if(response.body != null && response.bodyString != "[]" && response.body != 0) {
        _qaPassList = List.from(response.body)
            .map((e) => QaOverAllModel.fromJson(e))
            .toList();
      }
    } else {
      print('OverAll');
    }
    _isLoading = false;
    update();
  }
}
