import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AQAchievement extends GetxService{

  final ApiClient apiClient;

  AQAchievement({required this.apiClient});


  Future<Response> mQAAchievement(String projectId,String visitMonth,List<String> status) async {
    return await apiClient.postQAAchievementLogin(AppConstants.POST_QA_ACHIEVEMENT_URL,
        {
          "projectId": projectId,
          "visitMonth": visitMonth,
          "recordStatus": status
        });

   /* {
      "projectId": "7",
    "visitMonth": "Wave - 8 June",
    "recordStatus": [
    "pass",
    "pending"
    ]
  }*/
  }
}