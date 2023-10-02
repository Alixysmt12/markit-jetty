import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class OverallRepo extends GetxService{

  final ApiClient apiClient;

  OverallRepo({required this.apiClient});

  Future<Response> mQOverall(String id,String visitMonth,String quotaStatus) async {
    return await apiClient.postOverAll(AppConstants.POST_OVERALL_URL,
        {
          "projectId": id,
          "visitMonth": visitMonth,
          "quotaStatus": quotaStatus
        });
  }
}