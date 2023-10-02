import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class StatusQARepo extends GetxService{

  final ApiClient apiClient;

  StatusQARepo({required this.apiClient});


  Future<Response> statusQAAchievement(String projectId,String visitMonth,String pass,String pending) async {
    return await apiClient.postStatusQAAchievementLogin(AppConstants.POST_QA_STATUS_URL,
        {
          "projectId": projectId,
          "visitMonth": visitMonth,
          "recordStatus": [
            pass,
            pending
          ]
        });

     /* {
        "projectId": "120",
      "visitMonth": "Quota Testing",
      "recordStatus": [
      "pass",
      "pending"
      ]
    }*/
  }
}