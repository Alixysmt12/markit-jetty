import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class QAPassRepo extends GetxService {
  final ApiClient apiClient;

  QAPassRepo({required this.apiClient});

  Future<Response> mQAPass(String id,String visitMonth,String quotaStatus) async {
    return await apiClient.postQAPass(AppConstants.POST_QA_PASS_URL,
        {
          "projectId": id,
          "visitMonth": visitMonth,
          "quotaStatus": quotaStatus
        }
        /*{
        "projectId": "120",
        "visitMonth": "Quota Testing",
        "quotaStatus": "interLockQuota"
        }*/
        );
  }
}
