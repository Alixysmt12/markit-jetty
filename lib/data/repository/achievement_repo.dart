import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class TotalAchievement extends GetxService{
  final ApiClient apiClient;

  TotalAchievement({required this.apiClient});


  Future<Response> totalAchievement(String id,String visitMonth) async {
    return await apiClient.postTotalAchievement(AppConstants.TOTAL_ACHIEVEMENT,
        {
          "projectId": id,
          "visitMonth": visitMonth,
          "recordStatus": [
            "pass",
            "pending",
          ]
        });
  }
}