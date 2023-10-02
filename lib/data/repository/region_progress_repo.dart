import 'package:get/get.dart';
import 'package:markit_jetty/data/api/api_client.dart';
import 'package:markit_jetty/utils/app_constants.dart';

class RegionProgressRepo extends GetxService {
  final ApiClient apiClient;

  RegionProgressRepo({required this.apiClient});

  Future<Response>  regionProgress(String id,String visitMonth,String quotaStatus) async {
    return await apiClient.postRegion(AppConstants.POST_REGION_PROGRESS_URL,     {
      "projectId": id,
      "visitMonth": visitMonth,
      "quotaStatus": quotaStatus
    }

       /* {
        "projectId": "120",
        "visitMonth": "Quota Testing",
        "quotaStatus": "fixedQuota"
        }*/
    );
  }
}
