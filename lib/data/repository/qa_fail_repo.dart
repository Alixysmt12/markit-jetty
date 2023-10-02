import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class QAFailRepo extends GetxService{

  final ApiClient apiClient;

  QAFailRepo({required this.apiClient});

  Future<Response> mQAFail(String id,String visitMonth,String quotaStatus) async {
    return await apiClient.postQAFail(AppConstants.POST_QA_FAIL_URL,
        {
          "projectId": id,
          "visitMonth": visitMonth,
          "quotaStatus": quotaStatus
        });
  }
}