import 'package:get/get.dart';
import 'package:markit_jetty/data/repository/achievement_repo.dart';

class AchievementController extends GetxController implements GetxService {
  final TotalAchievement totalAchievement;

  AchievementController({required this.totalAchievement});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String> totalAchievementData(String id, String visitMonth) async {
    print("Total Ac Data");
    _isLoading = true;
    update();
    Response response = await totalAchievement.totalAchievement(id, visitMonth);
    String data = "";
    if (response.statusCode == 200) {
      print("Backend Total Ac Data");

      if(response.body != null) {

        data = response.body.toString();
        print("response ac");
        print(response.body.toString());
        update();
      }
      // responseModel = List.from(response.body).map((e) => TrackingModel.fromJson(e)).toList();
    } else {
      print("No Total Ac Data");
      //responseModel = ResponseModel();
      //responseModel = ResponseModel(false, response.statusText!);
      update();
    }
    _isLoading = false;
    update();
    return data;
  }
}
