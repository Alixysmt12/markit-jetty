import 'package:get/get.dart';
import 'package:markit_jetty/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class FieldAchievement extends GetxService{
  final ApiClient apiClient;

  FieldAchievement({required this.apiClient});


  Future<Response> fieldAchievement(String projectId,String visitMonth,List<String> status) async {
    return await apiClient.postFieldAchievementLogin(AppConstants.POST_FIELD_ACHIEVEMENT_URL,

        {
          "projectId": projectId,
          "visitMonth": visitMonth,
          "recordStatus": status
        }
       /*
        {
          "projectId": "7",
          "visitMonth": "Wave - 8 June",
          "recordStatus": [
            "pass",
            "pending"

          ]
        }*/
        );
  }
}